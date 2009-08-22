Return-Path: <cyrus@holtmann.org>
Message-ID: <508DFE744C1A4696B3D22CA7ED563C35@TSESUO>
From: "Abraham J. Velez \(EndoraSoft\)" <ajvelez@endorasoft.es>
To: <linux-bluetooth@vger.kernel.org>
Subject: Question about the connect Function and BlueZ.
Date: Sat, 22 Aug 2009 18:51:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Well, we have a problem in the Linux platfform with BlueZ. The problem is 
easy to explain:

We open a connexion (with bluetooth) with connect function (we use socket). 
Every connexion make in his own thread. This connexions are with Obex Push 
profile. This works without problems.

For the purposes of our applications, we need to cut this connection before 
the terminal (reduced the time of the ask in the terminal: the user confirm 
the sending). The call to connect function is blocking (because we need to 
know if the user of the terminal can not connect errno==ECONNREFUSED).


-------------------------------------------------------------------------------------------------------------------------------------------------------------
fcntl(func->handlesocket, F_SETFL, fcntl(func->handlesocket, F_GETFL,0) & 
~O_NONBLOCK);
func->refused = false;
error = connect(func->handlesocket, (struct sockaddr *)&rem_addr, 
sizeof(rem_addr));
if(error<0)
  {
    if(errno==ECONNREFUSED) func->refused = true;
    func->SetEvent(DIOLNXBTFSMEVENT_DISCONNECTING);
    break;
  }
------------------------------------------------------------------------------------------------------------------------------------------------------------

The problem is: How cancel this block connexion make with connect function?

If we call to this code (in other thread) the connect function waits to 
timeout of the terminal...

-------------------------------------------------------------------------------------------------------------------------------------------------------------
fcntl(handlesocket, F_SETFL, fcntl(handlesocket, F_GETFL,0) & ~O_NONBLOCK);
shutdown(handlesocket,SHUT_RDWR);
close(handlesocket);
handlesocket = -1;
-------------------------------------------------------------------------------------------------------------------------------------------------------------

The same code in Microsoft Windows Stack of Bluetooth "cancel" the connect 
function...

Any idea?

Thanks in advanced for your time ....

Best Regards,
Abraham. 


