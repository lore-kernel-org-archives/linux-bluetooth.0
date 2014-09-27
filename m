Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 2/4] shared/gatt-client: Add CSRK part to support signed write
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3D02B219753AD44CBDDDE484323B17741130B3FA@SHSMSX104.ccr.corp.intel.com>
Date: Sat, 27 Sep 2014 10:51:21 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BCAE391F-397F-402C-8179-675E53BD4F1A@holtmann.org>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com> <1411717728-15415-3-git-send-email-chao.jie.gu@intel.com> <9AF598FF-82F3-499C-8739-72947EDA695A@holtmann.org> <3D02B219753AD44CBDDDE484323B17741130B3FA@SHSMSX104.ccr.corp.intel.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chao Jie,

>>> +bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
>>> +				bool valid_local_csrk,
>>> +				uint8_t key[16]);
>> 
>> why do we have the parameter valid_local_csrk. I find that highly confusing. If you
>> do not have a valid CSRK, then do not call this function. It should be that simple.
>> 
> 
> My initial purpose to set this parameter valid_local_csrk here, user can call one API
> to set flag valid_local_csrk ture/false and CSRK key in one time.
> According to your proposal, I think it really result in confusion for user.
> 
> So for more clear to call API , I think we should split two API for upper layer:
> 1. When we need to set CSRK , check the CSRK is valid , then call bt_gatt_client_set_local_csrk
>  Just to pass one parameter key to function and in the function to set flag valid_local_csrk is true.
> 
> 2 When two device dispair each other, we should give user possibility to unset flag and CSRK.
>  So in this condition , we have to create bt_gatt_client_unset_local_csrk(struct bt_gatt_client *client)
>  to clear CSRK and set flag valid_local_csrk to false.
> 
> Do you think this thought would be ok for you?

I am not really worried about these details anyway. If you remove the bond between two devices, then the connection will be terminated. Which means that next time around you get a new bt_att object. If you do not have any CSRK the next time, you just not set them in the first place.

Regards

Marcel

