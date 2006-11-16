Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <455C568D.3000405@gmail.com>
Date: Thu, 16 Nov 2006 09:16:13 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <455B6987.3070703@gmail.com>
	<455B8696.2010405@xmission.com>	<360bc8300611151339y65320ab4o1c6a1ab4905ee638@mail.gmail.com>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA6@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA6@eumonex01.palmsource.com>
Subject: Re: [Bluez-users] RE :  Low quality audio on Bluetooth Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Frederic Dalleau escribi=F3:
> Hi,
> Can you send us the output of the dameon and your .a2dprc file?
> As usual, which player are you using?
> Thanks,
> Frederic

Hi,
At the end you can find the output. I think I have a clue why I get so =

low audio quality, I think that a2dpd is connecting to the hands free =

channel instead of the hifi channel  (check the sdpbrowse tools at the =

end). Is there anyway I can select to which channel a2dpd connects?
Cheers,
Manuel

OUTPUT FROM a2dpd:
Cannot open /dev/input/uinput: No such file or directory
a2dpd [Nov  8 2006 10:26:52] starting ...a2dpd addr=3D00:12:0E:06:C5:8A =

timer=3D4000 us [Nov  8 2006 10:26:52]
setscheduler returns -1 (errno=3D1:Operation not permitted)
main_thread:Accepting incoming tcp stream connection
New connection to bluetooth [44100 hz]
avrcp: Accepting incoming connection
avdtp: Accepting incoming connection
main_thread: Accepted 5
PCM thread 0.5 started
[1] Receiving failed on socket 0.5 error (0/4 bytes) errno=3D0:Success
Client thread 0.5 ending: error
main_thread:Accepting incoming tcp stream connection
main_thread: Accepted 5
PCM thread 0.5 started
[1] Receiving failed on socket 0.5 error (0/4 bytes) errno=3D0:Success
Client thread 0.5 ending: error
main_thread:Accepting incoming tcp stream connection
main_thread: Accepted 5
PCM thread 0.5 started
main_thread:Accepting incoming tcp stream connection
[1] Receiving failed on socket 0.5 error (-1/4 bytes) errno=3D11:Resource =

temporarily unavailable
Client thread 0.5 ending: timeout
main_thread: Accepted 10
PCM thread 0.10 started
DEBUG: a2dp_new: 00:12:0E:06:C5:8A, 44100
main_thread:Accepting incoming tcp stream connection
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination (psm_cmd=3D25)
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: a2dp_handle_avdtp_message: Read non command packet =

(msgtype=3D2,signal=3D1)
DEBUG: connect_stream: Got a Stream End Point Discovery (4 bytes) =

Response (msgtype=3D2,pkttype=3D0,lbl=3D0,sig=3D1,rfa=3D0)
02010408
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: Got capabilities response:
servcap_cap=3D1, servcap_len=3D0,
cap_type=3D7, length=3D6, media_type=3D0, codec=3D0
avrcp: socket 7: Connection from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
DEBUG: process_seid: Got Set Configurations Response (2 =

bytes:msgtype=3D2,pkttype=3D0,lbl=3D2,sig=3D3,rfa=3D0)
DEBUG: connect_stream: Sent stream start(seid=3D1)
DEBUG: connect_stream: Got start stream confirm
DEBUG: listen_thread: Listen thread running [control_sk=3D5]
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
avrcp: socket 7: Reading from 8A:C5:06:0E:12:00, mtu=3D672
handling SIGINT
main_thread: Accepted 11
Destroying lpA2dp, end of loop
DEBUG: a2dp_destroy: Begin
DEBUG: a2dp_free:
DEBUG: a2dp_destroy: a2dp_destroy(0x8058460) OK
Client thread 0.10 ending: no error
A2DPD still 2 clients running
socket 7: Receive failed 0 (error 0:Success)
avrcp: socket 7: timed out
A2DPD still 2 clients running
A2DPD terminated succesfully
----- END OF OUTPUT

sdpbrowse results :
Service Name: Audio Sink
Service RecHandle: 0x110b
Service Class ID List:
  "Audio Sink" (0x110b)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

Service Name: Headset
Service RecHandle: 0x1108
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Handsfree
Service RecHandle: 0x111e
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
