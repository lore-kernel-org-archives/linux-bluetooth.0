Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 28 Mar 2018 15:48:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Robert Lubas <robert.lubas@silvair.com>
Cc: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ V2] Mesh: Fix TTL in Config Heartbeat Publication
 Set
Message-ID: <20180328124808.GA11177@x1c.lan>
References: <20180322104442.27650-1-robert.lubas@silvair.com>
 <EC1DC23A-0357-4500-939A-98229F1BF561@intel.com>
 <fbdff2a6-8724-0372-0c2b-15cd34d2588c@silvair.com>
 <4AD7CCB7-A68D-4570-B575-34E8A32E5422@intel.com>
 <9748004b-5fe5-f768-0fca-15bb83aec51a@silvair.com>
 <dddbe66b-3d8b-3bae-37cd-7d11615e21de@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dddbe66b-3d8b-3bae-37cd-7d11615e21de@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Robert,

On Wed, Mar 28, 2018, Robert Lubas wrote:
> The problem is with the TTL field in the message (not valid value is hard
> codded). I proposed a fix by passing ttl into cmd_hb_pub_set (user has to be
> aware of valid values of the TTL as well as of another parameters in this
> function)
> 
> In the 4.4.1.2.15 Heartbeat Publication state (Mesh Profile spec) in the 3rd
> paragraph we can read that if the message is successfully processed (no
> invalid key index error) we should update the Heartbeat Publication state to
> the corresponding field values (defined in Table 4.120). Going to this table
> the Heartbeat Publication TTL state should be updated using message field
> TTL. The message field TTL has to be set according to the 4.2.17.4 Heartbeat
> Publication TTL (0x00-0x7F values are valid).
> 
> In the spec there is nothing about translation to the system settings
> mechanism in case of heartbeat.
> 
> Kindly asking for the review.

I think Brian is on vacation, so there will likely be no response from
him for awhile. The patch looks good to me, and even though we have the
default TTL concept, for testing purposes it's nice to be able to set
the TTL explicitly for the heartbeat configuration.

So, the patch has now been applied upstream. Thanks.

Johan
