Return-Path: <cyrus@holtmann.org>
Message-Id: <A3582650-894E-4E59-A156-42D2C5D973C0@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1521D68760504C61837D70AA89588A3E@iMe>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 6 Mar 2008 15:53:18 +0100
References: <fqnfkk$9np$1@ger.gmane.org> <1521D68760504C61837D70AA89588A3E@iMe>
Subject: Re: [Bluez-users] How to change the Hci packet size?
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

> Hi, what it the largest packet size for the Hci?
> Is it a configuration in the BlueZ or is it a configuration in the  
> adapter?

don't bother in trying. The firmware inside the Bluetooth chip is  
responsible for doing this job. It will pick the packet type that is  
best suitable.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
