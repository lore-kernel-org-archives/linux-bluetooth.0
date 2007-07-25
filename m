Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185350022.7111.97.camel@violet>
References: <1185293793.3641.129.camel@cookie.hadess.net>
	<1185311688.7111.72.camel@violet>
	<1185315051.3641.189.camel@cookie.hadess.net>
	<1185318541.3641.195.camel@cookie.hadess.net>
	<1185347068.7111.91.camel@violet>
	<1185348803.3641.213.camel@cookie.hadess.net>
	<1185350022.7111.97.camel@violet>
Date: Wed, 25 Jul 2007 08:56:02 +0100
Message-Id: <1185350162.3641.217.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make BluetoothClient work on all adapters
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

On Wed, 2007-07-25 at 09:53 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > > > However this includes that we have to monitor if the default adapter
> > > > > > changes or one adapter gets removed while being in the adapter selector
> > > > > > widget or device selector widget.
> > > > > 
> > > > > Fair enough, I knew this would be a sticky point. I'm trying to fix it
> > > > > up so that we use the default adapter by default with "NULL" passed as
> > > > > the adapter.
> > > > 
> > > > Here goes. This should correctly kill the disco on the old default
> > > > adapter and re-enable it on the new default adapter, when the default
> > > > adapter changes.
> > > 
> > > you patch is wrong. You are messing up a DBusConnection object with the
> > > BluetoothClient object in the callbacks of the DefaultAdapterChanged
> > > signal.
> > > 
> > > Actually I also don't like this way, we should store the default path
> > > globally since that is what really counts. The tree storing all
> > > information should be fully valid as long as we have an instance of the
> > > BluetoothClient object and it can store the information about the
> > > default adapter for us.
> > 
> > The tree storing all information is still valid, there's no information
> > there as to which is the default adapter.
> > 
> > And to be able to use the default_adapter in the instances, you need to
> > connect to the signal in the instances.
> 
> actually no. The information about the default adapter is global. I used
> a global variable for now. If we need more specific information later or
> wanna do some advanced magic, then we can fix that. For now storing the
> default adapter in a global variable is fine.

Ok.

> > If you're not interested in stopping the existing discoveries on the
> > default adapter when the default adapter changes, or transferring those
> > discoveries to other devices, then it will be much easier.
> > 
> > I'm not sure why we would carry on discovering devices if the model
> > showing the devices is going away though.
> 
> I think that we should not. If the adapter goes away, then the discovery
> should stop. However lets think about that later.

I didn't think of that particular case.

> > So, the only thing I'm supposed to do, is change the model
> > automatically, so that when we get the model for the default adapter,
> > the model should change automatically. That will require the
> > DefaultAdapterChanged signal to live in the instance, as in my patch, as
> > globally, we don't have any knownledge of the instances.
> 
> We can have that in the model if we connect the proper signals to the
> rows. That is the way I prefer, because the rest is messy and would need
> DBusProxy for every instance. We don't since the model should be global
> and actually valid for the lifetime of the application. However don't
> worry. We can fix this up in the background. Once we have proper widgets
> available, we don't have to expose the model to the applications anymore
> (or at least less).

What's needed for the patch to go in then? Should we just make sure that
we use the default adapter when NULL is passed to those few functions,
and that's it? Even easier...

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
