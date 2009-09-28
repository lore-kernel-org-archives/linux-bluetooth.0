Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 28 Sep 2009 11:14:16 +0200
From: "Anna Richter" <anna.richter1@gmx.net>
Message-ID: <20090928091416.278260@gmx.net>
MIME-Version: 1.0
Subject: Video Streaming over Bluetooth with bluez
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone!

I am writing my master thesis now and a part of it deals with video streaming over bluetooth in linux and I have some questions about how to implement it with bluez. I am new with bluetooth programming and I tried to find answers to my questions in the internet, but all what I found is very general information. It would be great, if you could help me.
My application consits of three units: server, gateway and client. The server sends the video packets (RTP/RTCP) to the gateway via Ethernet. Gateway receives them and should send them to the client over bluetooth. 

1) As far as I could find in the internet, the Video Distribution Profile is not yet supported in the current version of bluez. Is that right? On the bluez wiki page I found, that VDP was a proposal for the Google Summer of Code this year. Did anybody take this project so that VDP could be supported in the near future?

2) Since the VDP is apparently not yet supported, I thought of several possible ways of realising video streaming over blueotooth: SPP/L2CAP, BNEP/L2CAP and HCI.

a) HCI: Since the gateway receives the RTP packets with the recvfrom(...) command from the server it would be the most effective way to simply transfer them over bluetooth with HCI. That way no additional header would be neccessary and the effective throughput would be higher. Is it possible to use HCI without L2CAP with bluez? In some papers I read that it is not allowed to do it. But these papers were written in 2003 and I wonder, whether something has changed in that time. If it is possible to use HCI without L2CAP, where can I find the appropriate bluez-API for C for that purpose?

b) SPP/L2CAP: In my book "Bluetooth: Essentials for programmers" I found, that there is the send(...) command for transmiting data over bluetooth. So it should be possible just to send the received RTP packet (maximum size: 1500 Byte) with this send(...) command over bluetooth. In the book it was not explained, which profile this send(...) command belongs to. Is it right that I use the SPP by using the send(...)- and recv(...)-command? Is there any disadvantage in this solution?

c) BNEP/L2CAP: As far as I understand BNEP is good to send TCP/IP packets over bluetooth. So both gateway and client think, they communicate over TCP/IP, but in fact the communicate over bluetooth. I don't think, this solution would be the best in my case, since the gateway receives the payload of the TCP/IP packets from server: with the recvfrom(...) command it gets just the video packet containing the video payload and the RTP header. So it would be a waste of bitrate to enlarge this packet by adding the UDP header, the TCP/IP header and then the BNEP header and L2CAP header. Or is it still a good solution for my case and I just don't understand somenthing? Does bluez offer a API for C for the BNEP? I tried to find it in the directories of the bluez-4.53, but all I found were about bnep were the source codes and headersIs it necessary to create a specific BNEP-socket and transfer the data over BNEP using this socket?

d) There is also the GAVDP, but it is not for the video streaming itself, but just for the preparation of video streaming over bluetooth, right?

So for my application it seems to be the easiest and best way to use the SPP/L2CAP way with the send(...) and recv(...) commands to realise video streaming over bluetooth. Of course I know that the speed and the video quality may not be the best and until now it is better to use WLAN for video streaming instead of bluetooth. But my task is to do both and then compare them.

It would be a great help, if you could give me your opinion about my thoughts. Any questions, remarks, hints, ... are welcome.

Best wishes

Anna
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
