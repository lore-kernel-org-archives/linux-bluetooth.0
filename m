Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "pat" <pat@xvalheru.org>
To: "BlueZ" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] newbe: rfcomm_recv_frame: bad checksum in packet
Message-Id: <20040913151758.M47235@xvalheru.org>
In-Reply-To: <1094997603.5695.9.camel@pegasus>
References: <20040910155027.M37511@xvalheru.org> <1094997603.5695.9.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Sep 2004 17:20:24 +0200

Hi Marcel,

Thanks for your answer, but same problem is with Windows, so the problem is
with the cell phone - it needs new firmware (Nokia 6230). I'll update the
firmware and let you know the result.

Thanks once again.

     Pat

On Sun, 12 Sep 2004 16:00:03 +0200, Marcel Holtmann wrote
> Hi Pat,
> 
> > I have installed the BlueZ to my laptop because I want to use GPRT through the
> > Bluetooth. I have scripts and the rest configured and I'm able to connect and
> > upload some data, but within 30 seconds the connection go down. The system log
> > contains only this line "rfcomm_recv_frame: bad checksum in packet". Could
> > someone help me ???
> 
> actually this should never happen, because the underlaying L2CAP 
> layer is reliable. Try to use the latest 2.6 kernel and run "hcidump 
> -X" as root and show the output to us.
> 
> Regards
> 
> Marcel



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
