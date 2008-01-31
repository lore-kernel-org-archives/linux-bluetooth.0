Return-Path: <cyrus@holtmann.org>
Message-Id: <6983B6C6-94F2-43B2-8658-100CC53E4BFF@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200801312028.m0VKS8ST011488@alumnus.caltech.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Thu, 31 Jan 2008 22:48:40 +0200
References: <200801312028.m0VKS8ST011488@alumnus.caltech.edu>
Subject: Re: [Bluez-users] unique bus name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

On Jan 31, 2008, at 22:28, Russell A. Bell wrote:
> 	'Could you try running it manually as root with
> "/usr/lib/bluetooth/ bluetoothd-service-audio -s" as see what messages
> you get?'
>
> /etc/bluetooth# /usr/local/lib/bluetooth/bluetoothd-service-audio -s
> audio[5746]: Bluetooth Audio daemon
> audio[5746]: Config options: DisableHFP=true, SCORouting=PCM,  
> SourceCount=2
> audio[5746]: Unix socket created: 5
> audio[5746]: Adding service record failed: Connection refused
> audio[5746]: Unable to register HS AG service record
> audio[5746]: Unregistered manager path
> audio[5746]: Audio init failed!

I think that error could be caused by you not having a local SDP  
server running. You should either have sdpd running or have started  
hcid with the -s switch (the preferred way).

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
