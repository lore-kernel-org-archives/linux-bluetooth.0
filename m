Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 14 Nov 2006 04:19:14 -0800 (PST)
From: Sergey Krivov <krivov@yahoo.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611131424.06615.mhilzinger@linuxnewmedia.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-609204983-1163506754=:38780"
Message-ID: <947020.38780.qm@web31012.mail.mud.yahoo.com>
Subject: [Bluez-devel] python a2dp
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--0-609204983-1163506754=:38780
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

this is a partial realization of AVDTP, A2DP and AVRCP
profiles in python with simple example of a2dp-avrcp
server. it is probably far from a2dp alsa-plugin theme
since it is not written in C, but it might be useful
for prototype development. Anyway, have a look.

All the feedback is welcome.


 
____________________________________________________________________________________
Yahoo! Music Unlimited
Access over 1 million songs.
http://music.yahoo.com/unlimited
--0-609204983-1163506754=:38780
Content-Type: text/x-python; name="avdtp.py"
Content-Description: 831489387-avdtp.py
Content-Disposition: inline; filename="avdtp.py"

#! /usr/bin/env python
"""
Partial realization of AVDTP, A2DP and AVRCP profiles
and simple A2DP-AVRCP server

*  Copyright (C) 2006  Sergei Krivov <krivov@yahoo.com>
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program; if not, write to the Free Software
*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
"""


"""
install libsbc; check for /usr/lib/libsbc.so. http://sbc.sf.net
put this in your .asoundrc file
pcm.a2dpipe {
            type plug
            slave {
                  pcm "tee:default,'/tmp/a2dpipe', raw"
            }
}

select alsa output pcm device a2dpipe
make pipe by: mkfifo /tmp/a2dpipe
start by python avdtp.py
stop by killing the process
A2DP server can work with many ACP given in the beginning.
dynamical management of ACP is restricted to a single ACP
to initiate connection with the server press PLAY button on headphones
server starts as soon as some sound appeared in the pipe.
server uses alsa timing, so some dropouts can be experienced if timing
in alsa and headphones is different.
"""



import ctypes
from ctypes import Structure,c_uint8,c_uint16,c_ulong,c_uint32,c_void_p
import bluetooth
import struct
import time
import sys
import array
import os
import threading

#//Signal ids
AVDTP_DISCOVER=1
AVDTP_GET_CAPABILITIES=2
AVDTP_SET_CONFIGURATION=3
AVDTP_GET_CONFIGURATION=4
AVDTP_RECONFIGURE=5
AVDTP_OPEN =6
AVDTP_START =7
AVDTP_CLOSE =8
AVDTP_SUSPEND =9
AVDTP_ABORT =10
AVDTP_SECURITY_CONTROL =11

MEDIA_TRANSPORT_CATEGORY =1
MEDIA_CODEC =7

SBC_MEDIA_CODEC_TYPE =0
AUDIO_MEDIA_TYPE =0

#//Packet types
PACKET_TYPE_SINGLE =0
PACKET_TYPE_START =1
PACKET_TYPE_CONTINUE =2
PACKET_TYPE_END =3

#//Message Types
MESSAGE_TYPE_COMMAND =0
MESSAGE_TYPE_ACCEPT =2
MESSAGE_TYPE_REJECT =3

MEDIA_PACKET_HEADER_LENGTH =14
MAX_ADDITIONAL_CODEC=4

deb=1
tran=0

class message_header_single(Structure):
  _pack_=1
  _fields_=[("message_type",c_uint8,2),("packet_type",c_uint8,2)\
    ,("transaction_label",c_uint8,4),("signal_id",c_uint8,6),("rfa0",c_uint8,2)]
class message_header_start(Structure):
  _pack_=1
  _fields_=[("message_type",c_uint8,2),("packet_type",c_uint8,2),("nsop",c_uint8,8)\
    ,("transaction_label",c_uint8,4),("signal_id",c_uint8,6),("rfa0",c_uint8,2)]
class message_header_continue(Structure):
  _pack_=1
  _fields_=[("message_type",c_uint8,2),("packet_type",c_uint8,2)\
    ,("transaction_label",c_uint8,4)]
class message_single(Structure):
  _pack_=1
  _fields_=[("header",message_header_single),("rfa0",c_uint8,2),("acp_seid",c_uint8,6)]
class sbc_codec_elements(Structure):
  _pack_=1
  _fields_=[("channel_mode",c_uint8,4),("frequency",c_uint8,4)\
    ,("allocation_method",c_uint8,2),("subbands",c_uint8,2)\
    ,("block_length",c_uint8,4),("min_bitpool",c_uint8,8),("max_bitpool",c_uint8,8)]
class acp_seid_info(Structure):
  _pack_=1
  _fields_=[("rfa0",c_uint8,1),("inuse",c_uint8,1),("acp_seid",c_uint8,6)\
    ,("rfa1",c_uint8,3),("tsep",c_uint8,1),("media_type",c_uint8,4)]
class sepd_resp(Structure):
  _pack_=1
  _fields_=[("header",message_header_single)]
  for i in range(1+MAX_ADDITIONAL_CODEC):_fields_.append(("n%i" %(i),acp_seid_info))
class sepd_reject(Structure):
  _pack_=1
  _fields_=[("header",message_header_single),("error",c_uint8)]
class getcap_resp(Structure):
  _pack_=1
  _fields_=[("header",message_header_single)]
  for s in ("serv_cat","serv_cap_len","cap_type","length","media_type"\
    ,"media_codec_type"): _fields_.append((s,c_uint8,8))
  _fields_.append(("sbc_elements",sbc_codec_elements))  
class set_sbc_req(Structure):
  _pack_=1
  _fields_=[("header",message_header_single),("rfa0",c_uint8,2)\
    ,("acp_seid",c_uint8,6),("rfa1",c_uint8,2),("int_seid",c_uint8,6)]
  for s in ("serv_cap","serv_cap_len","cap_type","length","media_type"\
    ,"media_codec_type"): _fields_.append((s,c_uint8,8))
  _fields_.append(("sbc_elements",sbc_codec_elements))  
class set_sbc_resp(Structure):
  _pack_=1
  _fields_=[("header",message_header_single),("serv_cap",c_uint8,8),("acp_seid",c_uint8,8)]
class open_strm_resp(Structure):
  _pack_=1
  _fields_=[("header",message_header_single),("error",c_uint8,8)]
class start_strm_resp(Structure):
  _pack_=1
  _fields_=[("header",message_header_single),("rfa0",c_uint8,2),("acp_seid",c_uint8,6)\
    ,("error",c_uint8,8)]

def print_fields(st,gap=''):
  print gap+str(st.__class__)+':'
  for f in st._fields_:
    a=st.__getattribute__(f[0])
    try:
      b=a.__getattribute__("_fields_")
      print f[0]+":"
      print_fields(a,gap+'  ')
    except: print gap+str(f[0]),a
    


def avdtp_connect(dst,psm=25):
  sock=bluetooth.BluetoothSocket( bluetooth.L2CAP )
  sock.bind(("",psm))
  sock.connect((dst,psm))
  if deb: print "connected to ",dst,psm
  bluetooth.set_l2cap_mtu(sock,672)
  return sock

def avdtp_disconnect(sock):
  sock.close()


def init_command_single(req):
  global tran
  req.header.packet_type=PACKET_TYPE_SINGLE
  req.header.message_type=MESSAGE_TYPE_COMMAND
  req.header.transaction_label=tran
  req.header.rfa0=0
  tran=(tran+1) & 0xf
  return req

def send_packet(sock,packet):
  size=ctypes.sizeof(packet)
  if deb>1:
    print "sending packet",size,struct.unpack("%iB" %(size),packet)
    print_fields(packet)
  l=sock.send(packet)
  if l!=size: raise IOError('transmission error')
  
  
def receive_response(sock,resp_class,resp_error_class=None):
  data=sock.recv(1024)
  size=ctypes.sizeof(resp_class)
  if len(data)>size:
    if deb>1:print "warning, possibly wrong responce class ",len(data),size
  if len(data)<size:
    if deb>1:print "warning, got partial responce, pad with zeros",len(data),size
    dl=size-len(data)
    l0=[0 for i in range(dl)]
    data+=struct.pack("%iB" %(dl),*l0)
  resp=ctypes.cast(data,ctypes.POINTER(resp_class))
  resp=resp.contents
  if deb>1:
    print "received",struct.unpack("%iB" %(len(data)),data)
    print_fields(resp)
  return resp


def avdtp_get_capabilities(sock,seid):
  cmd=message_single()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_GET_CAPABILITIES
  cmd.acp_seid=seid
  send_packet(sock,cmd)
  resp=receive_response(sock,getcap_resp)
  return resp

def avdtp_discover(sock):
  cmd=message_single()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_DISCOVER
  send_packet(sock,cmd)
  resp=receive_response(sock,sepd_resp)
  lseid=[]
  for i in range(1+MAX_ADDITIONAL_CODEC):
    sep=resp.__getattribute__("n%i" %(i))
    seid=sep.acp_seid
    if seid:lseid.append(seid) # take non zero seid
  if deb:print "got %i seid" %(len(lseid))
  lsep=[(avdtp_get_capabilities(sock,seid),seid) for seid in lseid]  
  return lsep

def avdtp_discover_rsp(sock):
  global tran
  cmd=receive_response(sock,message_single)
  tran=cmd.header.transaction_label
  rsp=sepd_resp()
  rsp=init_command_single(rsp)
  rsp.header.message_type=MESSAGE_TYPE_ACCEPT
  rsp.header.signal_id=AVDTP_DISCOVER
  sbc=rsp.n0
  sbc.acp_seid=1
  sbc.inuse=0
  sbc.tsep=1
  sbc.media_type=SBC_MEDIA_CODEC_TYPE
  send_packet(sock,rsp)


def set_sbc_configuration(sock,capb_resp,seid,sbc_codec):
  cmd=set_sbc_req()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_SET_CONFIGURATION
  cmd.serv_cap=MEDIA_TRANSPORT_CATEGORY
  cmd.acp_seid=seid
  cmd.int_seid=1
  cmd.cap_type=MEDIA_CODEC
  cmd.length=6
  cmd.media_type=AUDIO_MEDIA_TYPE  
  cmd.media_codec_type=SBC_MEDIA_CODEC_TYPE
  cmd.sbc_elements=capb_resp.sbc_elements
  cmd.sbc_elements.allocation_method=2
#  values of parameters in sbc routine and here are different
  for par,vals in sbc_codec.conf_dict.items():
    codec_att=sbc_codec.par.__getattribute__(par)
    code=vals[codec_att]
    resp_att=capb_resp.sbc_elements.__getattribute__(par)
    if resp_att & code:
      if deb: print 'setting %s=%i, %i' %(par,code,codec_att)
      cmd.sbc_elements.__setattr__(par,code)
    else: 
      if deb: print 'can not set %s=%i, %i' %(par,code,codec_att)
  send_packet(sock,cmd)
  resp=receive_response(sock,set_sbc_resp)
  if resp.header.message_type!=MESSAGE_TYPE_ACCEPT:
    raise IOError('Can not set SBC codec parameters')
  if deb: print "Successfully set SBC codec parameters"
  return seid,sbc_codec  
  
def avdtp_set_configuration(sock,lsep,codecs):
  """ select codec from available codecs
      and sets codec configuration
      just SBC codec is implemented 
      return seid, codec
  """
  lsbc=[(resp,seid) for resp,seid in lsep if \
    resp.header.message_type!=MESSAGE_TYPE_REJECT and\
    resp.media_codec_type==SBC_MEDIA_CODEC_TYPE and\
    resp.media_type==AUDIO_MEDIA_TYPE]
  if not lsbc:  raise IOError('ACP site dose not have SBC codec')
  if len(lsbc)>1 and deb: print 'ACP site has more then one SBC codec, take first' # if ever possible 
  resp,seid=lsbc[0]
  if deb: print "seid=",seid
  return set_sbc_configuration(sock,resp,seid,codecs[SBC_MEDIA_CODEC_TYPE])
  
def avdtp_open(dst,sock,seid):
  """open the audio stream"""
  cmd=message_single()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_OPEN
  cmd.acp_seid=seid
  send_packet(sock,cmd)
  resp=receive_response(sock,open_strm_resp)
  if resp.error: raise IOError('Can not open stream')
  if deb: print "opened stream"
  return avdtp_connect(dst,25)

def avdtp_start(sock,seid):
  cmd=message_single()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_START
  cmd.acp_seid=seid
  send_packet(sock,cmd)
  resp=receive_response(sock,start_strm_resp)
  if resp.error: raise IOError('Can not start stream')
  if deb: print "started stream"

def avdtp_suspend(sock,seid):
  cmd=message_single()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_SUSPEND
  cmd.acp_seid=seid
  send_packet(sock,cmd)
  resp=receive_response(sock,start_strm_resp)
  if resp.error: raise IOError('Can not stop stream')
  if deb: print "suspended stream"

def avdtp_close(sock,seid):
  cmd=message_single()
  cmd=init_command_single(cmd)
  cmd.header.signal_id=AVDTP_CLOSE
  cmd.acp_seid=seid
  send_packet(sock,cmd)
  resp=receive_response(sock,open_strm_resp)
  if resp.error: raise IOError('Can not close stream')
  if deb: print "closed steam"
  

    
class media_packet_header(Structure):
    _pack_=1
    _fields_=[("cc",c_uint8,4),("x",c_uint8,1),("p",c_uint8,1),("v",c_uint8,2)\
      ,("pt",c_uint8,7),("m",c_uint8,1)\
      ,("sequence_number",c_uint16),("time_stamp",c_uint32),("ssrc",c_uint32)]
class media_payload_header(Structure):
    _pack_=1
    _fields_=[("frame_count",c_uint8,4),("rfa01",c_uint8,1),("is_last_fragment",c_uint8,1)\
    ,("is_first_fragment",c_uint8,1),("is_fragmented",c_uint8,1)]

def media_packet(data,timestamp,frame_count,seq_number):
  mtu=672
  if len(data)+ctypes.sizeof(media_payload_header)+ctypes.sizeof(media_packet_header)>mtu:
    raise ValueError('Media packet size >mtu')
  class _media_packet(Structure):
    _pack_=1
    _fields_=[("media_packet_header",media_packet_header)\
      ,("media_payload_header",media_payload_header)\
      ,("data",c_uint8*ctypes.sizeof(data))]
  packet=_media_packet()
  packet.media_packet_header.v=2
  packet.media_packet_header.pt=1
  packet.media_packet_header.sequence_number=seq_number
  packet.media_packet_header.time_stamp=timestamp
  packet.media_packet_header.ssrc=1
  packet.media_payload_header.frame_count=frame_count
  packet.media_payload_header.is_fragmented=0
  packet.media_payload_header.rfa=0
  packet.data=data
  return packet

##### AVCTP & AVRCP ##################################################################################

# Message types
AVCTP_COMMAND_FRAME=0
AVCTP_RESPONSE_FRAME=1

CMD_PASSTHROUGH=0
CMD_ACCEPTED=9

PLAY_OP=68  #0x44
STOP_OP=69  #0x45
PAUSE_OP=70 #0x46
NEXT_OP=75  #0x4b
PREV_OP=76  #0x4c

class avctp_header(Structure):
  _pack_=1
  _fields_=[("ipid",c_uint8,1),("cr",c_uint8,1),("packet_type",c_uint8,2),\
    ("transaction_label",c_uint8,4),("pid",c_uint16)]
class avctp_frame(Structure):
  _pack_=1
  _fields_=[("header",avctp_header),("ctype",c_uint8,4),("zeros",c_uint8,4),\
    ("subunit_id",c_uint8,3),("subunit_type",c_uint8,5),("opcode",c_uint8,8),\
    ("operand0",c_uint8,8),("operand1",c_uint8,8)]

def avrcp_accept_connection():
  sock=bluetooth.BluetoothSocket( bluetooth.L2CAP )
  port=23
  sock.bind(("",port))
  sock.listen(1)
  client_sock,address = sock.accept()
  print "Accepted connection from ",address
  return client_sock

def avrcp_receive_commands(sock,callback):
  while True:
    data=sock.recv(1024)
    if len(data)==0:break
    cmd=ctypes.cast(data,ctypes.POINTER(avctp_frame))
    cmd=cmd.contents
    if cmd.header.packet_type!=PACKET_TYPE_SINGLE: raise ValueError('packet type != PACKET_TYPE_SINGLE')
    if cmd.ctype==CMD_PASSTHROUGH: callback(cmd.operand0)
    cmd.header.ipid=0 # use the same packet for responce
    cmd.header.cr=AVCTP_RESPONSE_FRAME
    cmd.header.packet_type=PACKET_TYPE_SINGLE
    cmd.ctype=CMD_ACCEPTED
    send_packet(sock,cmd)
  sock.close()  
  
#####SBC codec, libscb #################################################################################

class sbc_struct(Structure):
  _fields_=[("flags",c_ulong),("frequency",c_uint32),("channel_mode",c_uint32),("joint",c_uint32)
    ,('block_length',c_uint32),('subbands',c_uint32),('bitpool',c_uint32)\
    ,('data',c_void_p),('size',c_uint32),('len',c_uint32)\
    ,('duration',c_ulong),    ('priv',c_void_p)]

class sbc:
  def __init__(self,*arg,**kwd):
    self.par=sbc_struct()
    self.libsbc=ctypes.CDLL('libsbc.so')
    err=self.libsbc.sbc_init(ctypes.byref(self.par),c_ulong(1))
    if err:   print 'error initializing sbc coder',err
    self.configure(*arg,**kwd)
  def configure(self,frequency=44100,channels=2):
    self.par.subbands=8
    self.par.block_length=16
    self.par.bitpool=32
    self.par.frequency=frequency
    self.par.channel_mode=channels
    self.conf_dict={}
    self.conf_dict['frequency']={48000:1,44100:2,32000:4,16000:8}
    self.conf_dict['subbands']={8:1,4:2}
    self.conf_dict['block_length']={16:1,12:2,8:4,4:8}
    self.conf_dict['channel_mode']={2:2,1:1}
  def encode(self,data):
    l=self.libsbc.sbc_encode(ctypes.byref(self.par),data,len(data))
    return l,self.par.data,self.par.len,self.par.duration
  def fin(self):
    self.libsbc.sbc_finish(ctypes.byref(self.par))

##### useful functions ################################################################################
class timer:
  def __init__(self):
    self.time=time.time()
  def dt_has_elapsed(self,dt):
    return (time.time()-self.time)*1000000>dt-5000  
  def dt(self):
    return (time.time()-self.time)*1000000
  def start(self):
    self.time=time.time()  

def stream_pcm_pipe(f,lacp,commands,extimer=None):
  """ streaming audio by reading pcm from a pipe or file.
  if extimer==None relays on pipe's timer, all packets are
  send as soon as read from the pipe.
  if extimer!=None the given timer is used to send packets.
  """
  packet_header_size=13
  min_encoding_size=512
  mtu=672
  lpackets=[]
  seq_number=0
  frame_count=0
  timestamp=0
  elapsedtime=0 
  buf=(c_uint8*mtu)()
  lenbuf=0
  data=""
  if extimer!=None:timer0=extimer()
  if deb: timer1=timer()
  timer2=timer()
  while True:
    time.sleep(0.00001) # some sleep
    rdata=f.read(1000) # read
    if 'quit' in commands: break
    if len(lacp)==0 or 'pause' in commands:
      if extimer!=None:timer0.start()
      if deb: timer1.start()
      timestamp=0
      frame_count=0
      lpackets=[]
      continue # no streams: just read data from pipe
    if len(rdata)>0:#change endiannes
      adata=array.array('H')
      adata.fromstring(rdata)
      adata.byteswap()
      rdata=adata.tostring()
    data+=rdata
    while len(data)>min_encoding_size: #encode
      l,pendata,lendata,duration=lacp[0].codec.encode(data)
      data=data[l:]
      if lenbuf+lendata+packet_header_size>mtu: #enough for packet
        packetdata=(c_uint8*lenbuf)()
        ctypes.memmove(packetdata,buf,lenbuf)
        lpackets.append(media_packet(packetdata,timestamp,frame_count,seq_number))
        timestamp=elapsedtime # for following packet
        frame_count=0
        seq_number+=1
        if deb and seq_number%1000==0:
          print "sent 1000 packets, elapsed time is %g ms" %(timer1.dt())
          timer1.start()
        buf=(c_uint8*mtu)()
        lenbuf=0
      ctypes.memmove(ctypes.addressof(buf)+lenbuf,pendata,lendata)
      lenbuf+=lendata
      frame_count+=1
      elapsedtime+=duration
    while lpackets: #send packets while there are any
      packet=lpackets[0]
      if extimer==None or timer0.dt_has_elapsed(packet.timestamp):        
        for acp in lacp:
          try:send_packet(acp.stream,packet)
          except bluetooth.BluetoothError: # close and remove dead ACP
            if deb: print "stream error ",acp.addr
            acp.stream.close()
            acp.sock.close()
            if deb: print "close stream ",acp.addr
            lacp.remove(acp)
            if deb:
              print "remove stream, number of streams left",len(lacp)
        del lpackets[0]
         
  
class acp: # container class to keep information about ACP
  def __init__(self,addr):
    self.addr=addr
    self.stream,self.sock,self.seid,self.codec=connect(addr)  

def connect(addr,psm=25):
  """connects to a2dp sink on address addr """
  sbc_codec=sbc(44100,2) # initialize sbc codec
  codecs={SBC_MEDIA_CODEC_TYPE:sbc_codec} # list the available codecs
  sock=avdtp_connect(addr,psm) # connect to the ACP side
  lsep=avdtp_discover(sock) # discover set of codec on ACP side
  seid,codec=avdtp_set_configuration(sock,lsep,codecs) # select and set codec parameters
  stream=avdtp_open(addr,sock,seid) # open audio stream
  avdtp_start(sock,seid) #start audio stream
  return stream,sock,seid,codec

def avdtp_discover_abort(sock):
  cmd=receive_response(sock,message_single)
  cmd.header.message_type=MESSAGE_TYPE_COMMAND
  cmd.header.signal_id=AVDTP_ABORT
  send_packet(sock,cmd)

def advertise_a2dp():
  """advertise a2dp source"""
  server_sock=bluetooth.BluetoothSocket( bluetooth.L2CAP )
  port=25
  server_sock.bind(("",port))
  server_sock.listen(1)
  print "listening on port %d" % port
  uuid = "110a"
  profile=[bluetooth.ADVANCED_AUDIO_PROFILE]
  classes=[bluetooth.AUDIO_SOURCE_CLASS,]
  bluetooth.advertise_service( server_sock, "Audio Source", service_id = "", service_classes = [], \
        profiles = [], provider = "", description = "")
  client_sock,(address,port) = server_sock.accept()
  print "Accepted connection from ",address
  return client_sock,address,port


##### simple multiple client A2DP & AVRCP streaming server  ##########################################

class a2dp_streamer ( threading.Thread ):
  def __init__ ( self, pipename, lacp,commands,timer=None):
    self.pipename=pipename 
    self.lacp=lacp # list of ACP
    self.timer=timer
    self.commands=commands
    threading.Thread.__init__ ( self )

  def run (self):
    stream_pcm_pipe(self.pipename,self.lacp,self.commands,self.timer)
 
def callback_xmms(com):
  if deb: print 'received command code',com
  if   com==PLAY_OP: os.popen('xmms --play')
  elif com==STOP_OP: os.popen('xmms --stop')
  elif com==PAUSE_OP:os.popen('xmms --pause')
  elif com==NEXT_OP: os.popen('xmms --fwd')
  elif com==PREV_OP: os.popen('xmms --rew')
  else: 
    if deb: print "unknown command code",com  
  return 1

class avrcp_server ( threading.Thread ):
  def __init__ ( self):
    threading.Thread.__init__ ( self )
  def run ( self ):
    while True:
      sock=avrcp_accept_connection()
      avrcp_receive_commands(sock,callback_xmms)

if __name__=="__main__":
  """instructions are in the beginning of the file"""
  deb=1
  control=avrcp_server()   # start avrcp
  control.start()          #
  lacp=[]
#  addr="00:0D:44:2A:A1:4C" # can start with online acp
#  lacp.append(acp(addr))   #
#  addr="00:07:A4:00:17:FD" # works with many acp simultaneously
#  lacp.append(acp(addr))   # but only if they are discovered at the beginning
  commands=[]
  f=open('/tmp/a2dpipe','rb',0)
  while True: 
#  dynamically manages new ACP
#  to initiate connection press PLAY button on headphones
#  works only with single ACP
#  discovery of second ACP destroys sound completely.
#  maybe bluetooth is not thread safe?
    streamer=a2dp_streamer(f,lacp,commands)
    streamer.start()
    try:
      sock2,addr,port=advertise_a2dp()
      commands.append('quit') #stop streamer
      streamer.join()
      avdtp_discover_abort(sock2)  
      sock2.close()
      lacp.append(acp(addr))
    except bluetooth.BluetoothError,what: print 'BluetoothError: ', what  
    commands.remove('quit')
    print 'number of ACP', len(lacp)
    
    
  

--0-609204983-1163506754=:38780
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--0-609204983-1163506754=:38780
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--0-609204983-1163506754=:38780--
