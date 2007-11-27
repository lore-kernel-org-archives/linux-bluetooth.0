Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474C131E.1060701@infitsrl.com>
Date: Tue, 27 Nov 2007 13:52:46 +0100
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>	<1196151954.17196.15.camel@aeonflux>
	<474BF69A.3030008@infitsrl.com>	<1196161587.17196.37.camel@aeonflux>
	<474BFBF5.50500@infitsrl.com> <1196164039.17196.47.camel@aeonflux>
In-Reply-To: <1196164039.17196.47.camel@aeonflux>
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
>>> as long as you only have one adapter attached to your system, you have
>>> attempts to run inquiry and paging at the same time. This is not working
>>> out. You can only do one thing at a time.
>>>   
>>>       
>> Yes but I'm using two adapters so It's not a problem...
>>     
>
> important information that you failed to mention. Two threads doesn't
> automatically mean two adatpers.
>
>   
In first mail I wrote : "...I've used two bluetooth dongles ...".
>> Yes I'known but the class isn't sufficient to known if remote device
>> has 
>> an obex push service, sure can I remove all classes
>> that certainly  did not have this service but it's a form of 
>> optimization rather than a solution to the problem.
>>     
>
> Actually all device supporting OBEX Push should set the object transfer
> service class. So you have to see if you also wanna support broken
> devices or if profile compliant devices are enough.
>
> Regards
>
> Marcel
>
>
>   
This is an important information I didn't known many thanks.
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
