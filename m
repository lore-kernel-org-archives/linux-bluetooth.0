Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:27:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdp: Fix sdp_get_profile_descs for Mac Os X Lion
Message-ID: <20120327112756.GC14481@x220>
References: <1332165847-12703-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1332165847-12703-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Mar 19, 2012, Frédéric Dalleau wrote:
> Mac OS X 10.7.3 publishes the following SDP record for HFP Gateway.
>       record #2
>           aid 0x0000 (SrvRecHndl)
>              uint 0x10003
>           aid 0x0001 (SrvClassIDList)
>              < uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
>           aid 0x0004 (ProtocolDescList)
>              < < uuid-16 0x0100 (L2CAP) > <
>              uuid-16 0x0003 (RFCOMM) uint 0x2 > >
>           aid 0x0005 (BrwGrpList)
>              < uuid-16 0x1002 (PubBrwsGrp) >
>           aid 0x0006 (LangBaseAttrIDList)
>              < uint 0x656e uint 0x6a uint 0x100 >
>           aid 0x0009 (BTProfileDescList)
>              < uuid-16 0x111e (Handsfree) uint 0x105 >
>           aid 0x0100 (SrvName)
>              str "Hands Free Audio Gateway"
>           aid 0x0301 (SuppDataStoresList)
>              uint 0x0
>           aid 0x0311 (SuppFeatures)
>              uint 0x0
> 
> BlueZ do not read correctly the version number of the profile.
> The patch fixes this.
> 
> From my understanding, the SDP profile descriptor is a list. The for
> loop in sdp_get_profile_desc iterates that list.  Until now, bluez
> expected a collection of either uuid or lists with a uuid and a
> version number. This can be represented as follow:
> list=(uuid, uuid, (uuid, version))
> 
> The patch fixes the situation where the profile descriptor list
> contains a uuid AND a version number both on the root level and not
> enclosed in a sublist. If the next item after uuid is uint16, then
> this is the version number. This can be represented as follow:
> list=(uuid, uuid, version, uuid, (uuid, version))
> 
> Note that core v4.0 spec. states that the Profile Descriptor
> list is a data sequence of profile descriptors. Each profile descriptor
> is a data sequence whose first element is a UUID and second element is
> a version number. This can be represented as follow:
> list=((uuid, version), (uuid, version))
> ---
>  lib/sdp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
