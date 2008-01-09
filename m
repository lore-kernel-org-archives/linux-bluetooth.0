Return-Path: <cyrus@holtmann.org>
Message-Id: <938E2C20-AD33-4236-8549-17E7235827B1@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1199816937.26099.75.camel@aeonflux>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Wed, 9 Jan 2008 05:06:07 +0200
References: <20080107230910.GA5883@ps.ms.mff.cuni.cz>
	<d89ddf300801071547k792a5b9fqe6e7e72e597b0e5f@mail.gmail.com>
	<1199805807.20835.10.camel@greatbear>
	<1199816937.26099.75.camel@aeonflux>
Subject: Re: [Bluez-devel] [PATCH] HFP method "SetupCall" + audio-api.txt
	update
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

Hi Marcel,

On Jan 8, 2008, at 20:28, Marcel Holtmann wrote:
>> Here is a patch for adding the SetupCall method , used for call  
>> setup on
>> hfp. Also adding a patch to update the audio-api.txt file for the  
>> same.
>>
>> Let me know if anything needs to be changed.
>
> the signal should be "CallTerminated" or its description is wrong. A
> name like "TerminateCall" would be a name for a method.

The CVS now has the correct name for the signal ("CallTerminated").

Johan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
