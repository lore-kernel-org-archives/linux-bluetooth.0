Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <685df2130710290924m65b5d4ccr2cb86c1570f063d8@mail.gmail.com>
References: <685df2130710290924m65b5d4ccr2cb86c1570f063d8@mail.gmail.com>
Date: Wed, 31 Oct 2007 17:26:53 +0100
Message-Id: <1193848013.32459.52.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Audio service with multiple adapters
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Joshua,

> I would like to call the 'CreateHeadset' method and associate the
> headset with a non-default adapter.
> 
> I am able to bond a headset to a non-default adapter with by
> referencing "/org/bluez/hci1" in the object path of the
> Adapter.CreateBonding method. 
> 
> However the 'CreateHeadset' method does not reference an adapter. It
> seems to associate the headset with the default adapter. I would like
> to associate headset A with the default adapter and headset B with a
> non-default adapter. 
> 
> Is there a way to associate a headset with a non-default adapter in a
> 'CreateHeadset' call?

actually there isn't at the moment. The only way is to physically switch
the dongles. This support doesn't have high priority.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
