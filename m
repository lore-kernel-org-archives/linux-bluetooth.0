Return-Path: <cyrus@holtmann.org>
Message-Id: <C1EE57B5-6047-4C5D-9DD7-0A1E6651AD83@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8F72DB7755DD6249B3C46D88BE7F5C0B03EEA6D5@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 29 May 2008 22:45:29 +0200
References: <8F72DB7755DD6249B3C46D88BE7F5C0B03EEA6D5@bgsmsx411.gar.corp.intel.com>
Subject: Re: [Bluez-users] Disable BlueZ profiles
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

Hi Kishore,

> We found there are some unnecessary profile can be discovered when  
> doing Bluetooth Inter-Op Testing such as  DUN, FTP, FAX, PAN, BIP,  
> HFP. How can I remove/disable these profiles?
>
with bluez-utils-3.32 you have an option to disable certain profiles  
and only test some part. However having all profiles enabled should  
not be a problem at all. So what is your issue regarding inter-op  
testing?

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
