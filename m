Return-Path: <maxime.chevallier@openwide.fr>
Date: Wed, 17 Feb 2016 08:25:35 +0100
From: Maxime Chevallier <maxime.chevallier@openwide.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC][PATCH] Add Set Advertising Parameters command
Message-ID: <20160217072535.GA11822@vps217108.ovh.net>
References: <20160216130927.GA10374@vps217108.ovh.net>
 <D9C33327-2669-4135-9DAA-2109B457B021@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D9C33327-2669-4135-9DAA-2109B457B021@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2016 at 10:11:22AM -0800, Marcel Holtmann wrote:
> Hi Chevallier,
> 
> > ---
> > doc/mgmt-api.txt | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 67 insertions(+)
> > 
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 731a088..4b842fd 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -2596,6 +2596,7 @@ Add Advertising Command
> > 		4	Add TX Power field to Adv_Data
> > 		5	Add Appearance field to Scan_Rsp
> > 		6	Add Local Name in Scan_Rsp
> > +		7	Pending Parameters
> > 
> > 	When the connectable flag is set, then the controller will use
> > 	undirected connectable advertising. The value of the connectable
> > @@ -2623,6 +2624,12 @@ Add Advertising Command
> > 	supported to provide less air traffic for devices implementing
> > 	broadcaster role.
> > 
> > +	If the Pending Parameters flag is set, the Advertising Instance
> > +	will only be queued when the Set Advertising Parameters command
> > +	is issued, with the correct Instance identifier. If the next
> > +	command is not a Set Advertising Parameters commmand, the current
> > +	Advertising Instance is cancelled.
> > +
> 
> this is an API design, I prefer to not support. It is really complicated and does not feel like a clean design.

I agree, this was sloppy design.

> 
> > 	The Duration parameter configures the length of an Instance. The
> > 	value is in seconds.
> > 
> > @@ -2680,6 +2687,66 @@ Add Advertising Command
> > 				Invalid Index
> > 
> > 
> > +Set Advertising Parameters Command
> > +==================================
> > +
> > +	Command Code:		0x003f
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Instance (1 Octet)
> > +				Adv_Interval_min (2 Octets)
> > +				Adv_Interval_max (2 Octets)
> > +	Return Parameters:
> > +
> > +	This command is used to set advertising parameters for a Bluetooth
> > +	Low Energy controller.
> > +
> > +	This command can be used to configure global advertising parameters
> > +	that will be applied for advertising issued by the Set Advertising
> > +	command.
> > +
> > +	This command can also be used to configure single Advertising
> > +	Instances. In that case, the parameters applied for the Advertising
> > +	Instance will override global Advertising Parameters when the
> > +	Adversiting Instance is running.
> > +
> > +	When configuring an Advertising Instance, the Instance must have
> > +	been added with the flag "Pending parameters". The Advertising
> > +	Instance will be added to queue only when the Set Advertising
> > +	Parameters will be issued.
> > +
> > +	The Instance parameter designates what we want to configure.
> > +	If the Instance parameter is 0, the Advertising Parameters apply
> > +	globally, for both the advertising issued with the Set Adverting
> > +	and the Advertising Instances issued with Add Averting.
> 
> I wonder if we actually want to include the Instance parameter at all here. I mean, why not just have some global setting for advertising parameters and just run with it.
> 
> However would fine grained per instance setting actually help you? If you have an instance with a higher interval it will consume the extra power.
> 
> And honestly if we ever really need super fine grained control, then I rather design an Add Enhanced Advertising command after we figured out what we really want. Especially looking forward on the next Bluetooth specification, I prefer not to lock myself in at this point in time.
> 
> So if we want to add a global Set Advertising Parameters similar to Set Scan Parameters then I am fine with that, but anything more complex seems not the right solution at this point.

I'm fine with the 'global configuration' approach for my particular use-case.
Your proposal of expanding later-on with an 'Enhanced' version of Add
Advertising seems cleaner, and as you said I don't really need this anyway.
I'll send a patch with my proposal for a Set Advertising Parameters,
that should look like Set Scan Parameters.
