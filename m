Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445AEC24.1010908@rootcore.co.za>
From: Charles Majola <charles@rootcore.co.za>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluez-utils vs patches
References: <4459F354.3020500@ubuntu.com> <1146786624.2885.151.camel@hades.cambridge.redhat.com>
In-Reply-To: <1146786624.2885.151.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 05 May 2006 08:09:40 +0200



David Woodhouse wrote:
> On Thu, 2006-05-04 at 14:28 +0200, Charles Majola wrote:
>   
>> After a lot of testing and user input is seems that applying the
>> patches from git://.. ../holtmann/bluetooth-2.6.git bluez-utils blocks
>> the functionality of HID devices. disabling bluez-utils get everything
>> to work fine. dunno how to report this as a bug as of yet.
>>     
>
> The problem seems to be just that we switch the Bluetooth device from
> HID mode, where it automatically connects with the remote keyboard and
> mouse, to HCI mode, where it expects _us_ to do that. And we don't
> actually manage to reconnect to the existing keyboard and mouse.
>
> Bluetooth HID devices _do_ work, to a certain extent, but not without
> manually repairing the devices, I believe. We don't have it working
> transparently, because I don't think we know how.
>   

We can have a GUI or something to manage the device, so that by default 
we leave the device in HID mode and the user can manually change it to 
HCI and start a HID daemon.

> I suspect there must be a way to query a device in HID mode and find out
> which remote HID devices it's connected to -- then we can immediately
> try to reconnect to those devices after we switch to HCI mode. Or
> there's something else we're missing.
>
>   
I suppose we can do that.

--
chmj


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
