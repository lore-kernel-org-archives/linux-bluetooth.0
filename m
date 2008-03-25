Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300803250516j6cf27fdbjf0740759b823435a@mail.gmail.com>
Date: Tue, 25 Mar 2008 06:16:20 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
MIME-Version: 1.0
References: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
Subject: Re: [Bluez-users] ACL connection handle
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

Paul/Matt

>      I have a bluetooth module in which there is an option  to select the
> interface (HCI or PCM) for the next SCO connection.This is done by sending
> an HCI command .

the infineon works this way. I believe the timing of this hci command
(after establishing acl, before establishing sco) will require the
code to be invoked from inside our audio service.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
