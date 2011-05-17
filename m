Return-Path: <cyrus@holtmann.org>
From: Alan <alanbluetooth@AiAware.com>
To: linux-bluetooth@vger.kernel.org
Subject: Does any one recognise this protocol? is it RF_COMM
Date: Tue, 17 May 2011 17:15:46 +1000
MIME-Version: 1.0
Message-Id: <201105171715.47064.alanbluetooth@aiaware.com>
Content-Type: Text/Plain;
  charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to write an OS driver for some propeitary hardware.
I have hit brick wall and need to go back and check what I know so far and 
turn over the rocks on the bits I hoped I could ignore. 


I am wondering if I made faulty guess early on.  hence this question.



What protocol is this?   Can it be RF_COMM ?

below is an edited extract of SnoppyPro logs from the windows software talking 
to the real physical device.

My question is what protocol are all the wrappers.
 I beleieve I identified HCI-ACL / L2CAp/ UNK / Proprietary.

The Unk one is probably something standard. As I can feed the proprietary part 
into an RF_COMM socket under linux and the device responds as if I am the 
windows machine. I thook that to mean Windows was talking RF_COMM.

Howver when I have unix software pretend  be the device and listen( ) the 
accept( ) never returns if it is the winodw software talking to me, but does 
when it is my linux software talking to my enulated on linux device.
I can post full hcidump of the failure to connect if you indicate what 
settings are intelligible to you, Im finding raw the most informative  as i 
can compare it to Snopypro logs....  
But expect people who knows things would understand the gobbledegooked
output modes better. 

The snoopy pro logs are at the USB level(?), and contain one extra (internal) 
layer of protocol data I do not undertsand. I think it is RF_COMM

Typical packets
Physical devices packet sent to Windows
113     in      up      0x82    28.093  28.093  00
TransferBuffer: 0x0000002b (43) length
pre  0000: 2b 20 27 00    23 00 41 00    09 ef 3f 
wrap 0000: 7e[1f 00](61)  24:ac:18:25:80:00 => 00:00:00:00:00:00
cmnd 0000: 02 00 00 04  70 00 01 00  00 00 00 01  00 00 00 40

Windows PC Packet sent to Device
122     out     down    0x02    28.140  28.140  00
TransferBuffer: 0x00000024 (36) length
pre  0000: 2b 20 20 00    1c 00 8c 00    0b ff 2f 00    
wrap 0000: 7e[17 00](69)  00:00:00:00:00:00 => 01:00:00:00:00:00
cmnd 0000: 01 02 76 65  72 0d 0a 86  

wrap and cmnd lines are the Device specific protocol burried in what look like 
lower layers. My LinuxSoftware emulates the Windows software by injecting the 
packets starting at 7E up the second last byte, into an RF_COMM socket.

What I think I know
Im pretty sure the   2b 20 20 00  is
Protocol: “Core_V4.0.pdf” Figure 5.2: HCI ACL Data Packet   p429
and 1c 00 8c 00
is L2CAP  [size and channel ID].

Does anyone recognise a protocol runnign on L2CAP that looks like this

09 ef 3f       Data        40   for inbound packets and
0b ff 2f 00    Data       86  for outbound packets

Here are the same packets dumped RAW for Linux Software talking
physical devices.  
(I cant get packets for windw softwware talking emulated device as the conect 
fails. Thats the problem)

Note there are binary differences in both the L2CAP and RFCOMM parts.
Most worrying to me is the missing 0.
> 02 2B 20 27 00 23 00 40 00 09 EF 3F 7E 1F 00 61 24 AC 18 25 
  80 00 00 00 00 00 00 00 02 00 00 04 70 00 01 00 00 00 00 01 
  00 00 00 40 
Linux RFComm packet.
< 02 2B 20 1F 00 1B 00 4D 00 0B EF 2F 7E 17 00 69 00 00 00 00 
  00 00 01 00 00 00 00 00 01 02 76 65 72 0D 0A 9A 

Any idea why the differences or where there is a reasonable document on what 
those RF_COMM bytes mean.
Im probably goign to have to go deep enough to understand the connect process.


          Alan
