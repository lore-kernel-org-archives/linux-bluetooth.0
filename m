Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 15:38:11 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
    pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Subject: Re: [PATCH 1/9] Bluetooth: Add BT_AMP_POLICY socket option
In-Reply-To: <1318549090.15441.49.camel@aeonflux>
Message-ID: <alpine.DEB.2.02.1110141410410.9993@mathewm-linux>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>  <1318543247-27130-2-git-send-email-mathewm@codeaurora.org> <1318549090.15441.49.camel@aeonflux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 13 Oct 2011, Marcel Holtmann wrote:

> Hi Mat,
>
>> Allow control of AMP functionality on L2CAP sockets. By default,
>> connections will be restricted to BR/EDR.  Manipulating the
>> BT_AMP_POLICY option allows for channels to be moved to or created
>> on AMP controllers.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
>>  1 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index e727555..14ae418 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -77,6 +77,33 @@ struct bt_power {
>>  #define BT_POWER_FORCE_ACTIVE_OFF 0
>>  #define BT_POWER_FORCE_ACTIVE_ON  1
>>
>> +#define BT_AMP_POLICY	10
>> +
>> +/* Require BR/EDR (default policy)
>> + *   AMP controllers cannot be used.
>> + *   Channel move requests from the remote device are denied.
>> + *   If the L2CAP channel is currently using AMP, move the channel to BR/EDR.
>> + */
>> +#define BT_AMP_POLICY_REQUIRE_BR_EDR   0
>
> so lets brainstorm a little bit with the names here. Do we really wanna
> use the term AMP_POLICY? Is it really AMP specific? Or do we better make
> ourselves a bit more future proof?
>
> I am currently thinking a bit more generic. Maybe this is not the best
> choice, but lets entertain this for a bit. So what about calling this
> BT_CHANNEL_POLICY?
>
> And instead of REQUIRE_BR_EDR I would call it BREDR_ONLY.

It's no problem to fine-tune the names.

So, if BT_CHANNEL_POLICY is a good option name, how about these option 
values:

BT_CHANNEL_POLICY_BREDR_ONLY
BT_CHANNEL_POLICY_AMP_PREFERRED
BT_CHANNEL_POLICY_BREDR_PREFERRED


>> +/* Prefer AMP
>> + *   Allow use of AMP controllers
>> + *   If the L2CAP channel is currently on BR/EDR and AMP controller
>> + *     resources are available, initiate a channel move to AMP.
>> + *   Channel move requests from the remote device are allowed.
>> + *   If the L2CAP socket has not been connected yet, try to create
>> + *     and configure the channel directly on an AMP controller rather
>> + *     than BR/EDR.
>> + */
>> +#define BT_AMP_POLICY_PREFER_AMP       1
>> +
>> +/* Prefer BR/EDR
>> + *   Allow use of AMP controllers.
>> + *   If the L2CAP channel is currently on AMP, move it to BR/EDR.
>> + *   Channel move requests from the remote device are allowed.
>> + */
>> +#define BT_AMP_POLICY_PREFER_BR_EDR    2
>
> We might also wanna look into the option of having a SCM message in the
> socket that tells us the current type. Or at least tells us when we
> successfully switched to AMP or back to BR/EDR. Since obviously we are
> not blocking on the setsockopt call.
>
> Not sure if applications actually do care, but for OBEX it might be
> interesting to know if you are on an AMP controller right now or not.

Yes, that would be a nice feature.  OBEX seems to work well even 
without it, though.  The OBEX connection is made over BREDR, and the 
socket option is changed after the OBEX connection is made but before 
any gets or puts.  What you see in hcidump is that the move starts 
before the first get or put goes out over BREDR - those OBEX packets 
sit in the ERTM tx queue while the channel move happens.  When the 
move completes, the transfer immediatly proceeds on the AMP 
controller.


Regards,
--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
