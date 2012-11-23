Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1D52C441D64244F0ABA8B962523624AC@sisodomain.com>
References: <2254742.168381353662862601.JavaMail.weblogic@epml01>
	<CABBYNZ+-2YWROExMEoMxSfYTyXT1oeOpHjJECNs-xA7vtaAx_g@mail.gmail.com>
	<1D52C441D64244F0ABA8B962523624AC@sisodomain.com>
Date: Fri, 23 Nov 2012 16:06:44 +0200
Message-ID: <CABBYNZJ=-OXkAq9MWrRTBgmTx85hSy=u=r8sUDYDhbBVPCshNw@mail.gmail.com>
Subject: Re: Query regarding device discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 23, 2012 at 3:24 PM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> Hi Luiz,
>
> --------------------------------------------------
> From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
> Sent: Friday, November 23, 2012 3:24 PM
> To: "Jaganath" <jaganath.k@samsung.com>
> Cc: <linux-bluetooth@vger.kernel.org>
> Subject: Re: Query regarding device discovery
>
>
>> Hi,
>>
>> On Fri, Nov 23, 2012 at 11:27 AM, JAGANATH KANAKKASSERY
>> <jaganath.k@samsung.com> wrote:
>>>
>>> Hello,
>>>
>>> I have a doubt with current discovery mechanism.
>>>
>>> Suppose application 1 calls "StartDiscovery". for which "Discovering =
>>> TRUE" comes
>>> and then deviceFound signals starts coming.
>>> In the mean time application 2 calls "StartDiscovery" which will be
>>> queued in BlueZ.
>>> Then "discovering = FALSE" comes for the discovery initiated from
>>> application 1.
>>> Then as per BlueZ design, it will restart discovery for application 1
>>> since it has not
>>> called "StopDiscovery" yet. So "discovering = TRUE" comes again, which
>>> application 2
>>> thinks that it belongs to him.
>>> Then if application 1 calls "StopDiscovery" immediately, discovery will
>>> be stopped
>>> and "Discovering = FALSE" comes with which application 2 too thinks that
>>> discovery
>>> initiated by him is also done.
>>> So eventually application 2 will not get any devices.
>>> So I think with current design, applications that are interested only in
>>> one complete
>>> inquiry session will be in trouble.
>>>
>>> So can we disable the automatic reinitiating of device discovery?
>>> Or is there any way to handle this scenario?
>>
>>
>>
>> StartDiscovery doesn't queue the sessions, it actually increase the
>> reference to the same discovery session which became shared between
>> the callers, it should not interfere with the ongoing discovery nor
>> change how we emit Discovering. That being said the concept of one
>> shot inquiry is flawed since it can miss devices, with addition of LE
>> this is even more visible because each inquiry is only 5.12 sec., you
>> can still detect when an inquiry is active just check when Discovering
>> is TRUE and nope it should not matter if there is 1 or 20 application
>> listening to it once Discovery switch to TRUE we are inquiring/scan
>> when it switch to FALSE it has stopped and is probably doing name
>> resolving.
>
>
> With this concept even if inquiry is completed, Discovery = FALSE should not
> be sent. Because anyway BlueZ will start a new Discovery on its own.
> So application gets Discovery = FALSE and then immediately Discovery = TRUE.
> So I think until application calls "StopDiscovery", Discovery = FALSE should
> not be sent

StartDiscovery processing with 3 instances is like this:

StartDiscovery #1
org.bluez.Adapter.Discovering=TRUE
  Inquiry
  name resolving
org.bluez.Adapter.Discovering=FALSE
org.bluez.Adapter.Discovering=TRUE
  Inquiry
  name resolving
org.bluez.Adapter.Discovering=FALSE
StartDiscovery #2
org.bluez.Adapter.Discovering=TRUE
  Inquiry
StartDiscovery #3
  name resolving
org.bluez.Adapter.Discovering=FALSE
...
org.bluez.Adapter.Discovering=TRUE
StopDiscovery #3
  Inquiry
StopDiscovery #2
StopDiscovery #1
org.bluez.Adapter.Discovering=FALSE

So org.bluez.Adapter.Discovering=TRUE will track each individual round
of the inquiry+name resolving, org.bluez.Adapter.Discovering=FALSE is
there just to let you know when another round is about to start in
case anyones cares about each individual round or want to do a single
round of discovery.

--
Luiz Augusto von Dentz
