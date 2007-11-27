Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474BFBF5.50500@infitsrl.com>
Date: Tue, 27 Nov 2007 12:13:57 +0100
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>	<1196151954.17196.15.camel@aeonflux>
	<474BF69A.3030008@infitsrl.com>
	<1196161587.17196.37.camel@aeonflux>
In-Reply-To: <1196161587.17196.37.camel@aeonflux>
Subject: Re: [Bluez-devel] Scan and push images
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

Marcel Holtmann ha scritto:
> Hi Fabrizio,
>
>   
>> Ok for the subject, excuse me.
>>     
>
> and please inline response. Otherwise it is hard to follow.
>
>   
>> I can't undertand "You are simply blocking the baseband with your random 
>> attempts", where are the random attemps?
>> One thread is dedicated to make inquiry, it bind on a specific local 
>> adapter and make an infinite loop of inquiry (with a parametric sleep on 
>> every iteration).
>>
>> On the other side for every device discovered it's lauched a thread for 
>> these operations:
>> 1) sdp query for OPUSH service (serialized with a mutex)
>> 2) connection to eventually discovered RFCOMM channel of the object push 
>> service
>> 3) push of the content (with my own working obex implementation)
>>     
>
> as long as you only have one adapter attached to your system, you have
> attempts to run inquiry and paging at the same time. This is not working
> out. You can only do one thing at a time.
>   
Yes but I'm using two adapters so It's not a problem...
>   
>> I'd like to accept Your suggests but:
>> - If I use periodic inquiry I need obligatory dbus to  receive callback 
>> events?
>>     
>
> You can do it by hand on a raw socket, but why would you? D-Bus gives it
> to you nicely.
>   
Ok, I've to look about using dbus in plain C because I don't want to use 
Glib.
>   
>> - How can I perform pre-filter on remote devices that support object 
>> transfer if I've not discovered their servies?
>>     
>
> Check the Bluetooth specification. Every inquiry result contains a 3
> byte class of device value.
>
> Regards
>
> Marcel
>
>   
Yes I'known but the class isn't sufficient to known if remote device has 
an obex push service, sure can I remove all classes
that certainly  did not have this service but it's a form of 
optimization rather than a solution to the problem.

> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>   



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
