Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197984959.21252.31.camel@greatbear>
References: <1197984959.21252.31.camel@greatbear>
Date: Tue, 18 Dec 2007 19:14:07 +0100
Message-Id: <1198001647.8050.183.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [HFP] New Methods/Signals.
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

Hi Alok,

> some new Methods/Signals are required for HFP in the audio service. Here
> are the ones needed as of now. 

are they using the org.bluez.audio.Headset interface or are they meant
to be in a org.bluez.audio.Handsfree interface?

> Method:
> 	void CallSetup(uint16 value)
> 	
> 		Used to send "callsetup" indicator value to the HF.
> 
> Signal:
> 	void TerminateCall()
> 		
> 		This signal is sent when an ongoing call is terminated.
> 
> 
> An appropriate method name would be IndicateCall(), But thats already
> used for Alerting(RING) the Headset/HFP. 

In case they are in the audio.Headset interface, then use SetupCall. Can
we use strings to express the value parameter?

> Is it possible to use Alert() instead of IndicateCall() to RING the
> headset/HF and use IndicateCall to send "callsetup" indicator? 

We can't change the API. Only a move to BlueZ 4.x could change the API.

> The headset method implementations start with hs_* . Should the hf
> methods prepend hf_ to them for distinguishing them from headset
> methods ?   

Sure.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
