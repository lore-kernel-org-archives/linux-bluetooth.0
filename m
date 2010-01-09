Return-Path: <cyrus@holtmann.org>
From: Mailing List SVR <lists@svrinformatica.it>
Reply-To: lists@svrinformatica.it
To: linux-bluetooth@vger.kernel.org
Subject: pc as headset: some progress but still no audio
Date: Sat, 9 Jan 2010 11:42:00 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_41FSLZMsILP9vlH"
Message-Id: <201001091142.00568.lists@svrinformatica.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_41FSLZMsILP9vlH
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I made some progress:

1) my phone can now recognize my pc as an headset
2) I'm able to pair the two device
3) I advertise the hsp service with the attacched pybluez script
4) the phone can connect to the pc and the output of the script is:

Waiting for connection on RFCOMM 1
Accepted connection  ('00:1E:96:00:07:D2', 1)
received
OK 

so the connection is successfull and the phone answer ok to AT+CKPD
5) I run bluetoothd -n -d and I see some errors like this:

bluetoothd[5938]: No matching connection found for handle 1 
6) with hcidump I see sco data:

> SCO data: handle 1 flags 0x00 dlen 48

and I think this sco data cause the error "No matching connection found for 
handle 1"

so I think there is something wrong in the sco link estabilishment, can you 
please give my some hints?

Is there a way to use a pc as an headset using bluez?

thanks
Nicola



--Boundary-00=_41FSLZMsILP9vlH
Content-Type: text/x-python;
  charset="UTF-8";
  name="testhsp.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="testhsp.py"

from bluetooth import *

server_sock=BluetoothSocket( RFCOMM )
server_sock.bind(("",PORT_ANY))
server_sock.listen(1)

port = server_sock.getsockname()[1]

advertise_service( server_sock, "Headset",
                                   service_classes = [ HEADSET_CLASS,GENERIC_AUDIO_CLASS ],
                                   profiles =[ HEADSET_PROFILE ] )

print "Waiting for connection on RFCOMM %d" %port

client_sock, client_info = server_sock.accept()
print "Accepted connection ", client_info
client_sock.send("AT+CKPD\r")

try:
        while True:
                data = client_sock.recv(1024)
                print "received %s" % data

except IOError:
        pass

print "disconnect"

client_sock.close()
server_sock.close() 

--Boundary-00=_41FSLZMsILP9vlH--
