Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <473B5E8D.1010401@moussaud.org>
Date: Wed, 14 Nov 2007 21:46:05 +0100
From: David MOUSSAUD <david@moussaud.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <473A9B06.8040108@moussaud.org>
	<d89ddf300711141239u468f4a86mb43c842cae00c90@mail.gmail.com>
In-Reply-To: <d89ddf300711141239u468f4a86mb43c842cae00c90@mail.gmail.com>
Subject: Re: [Bluez-users] Problem activating audio service
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

thanks Brad but i'have finally found the solution :
bluez-utils was not configured with the option --enable-audio (it seems 
that the option --enable-all does not work)

Now it works ! (unless with skype :-(

Brad Midgley wrote:
> David
>
>   
>> Error org.bluez.Error.NoSuchService: No such service
>>     
>
> Is the service in place in
> /usr[/local]/lib/bluetooth/bluetoothd-service-audio? what is in
> /etc/bluetooth/audio.service?
>
>   

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
