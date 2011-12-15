Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111215120851.GA10113@x220>
References: <1323950056-28708-1-git-send-email-hemant.gupta@stericsson.com>
	<20111215120851.GA10113@x220>
Date: Thu, 15 Dec 2011 19:17:22 +0530
Message-ID: <CACj007=R3bmR2e=xgAdSXPXb12OdkAPXh_0qGba+mM46KBjjyQ@mail.gmail.com>
Subject: Re: [PATCHv2] mgmt: Add support for Passkey handling
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Dec 15, 2011 at 5:38 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Thu, Dec 15, 2011, Hemant Gupta wrote:
>> @@ -218,7 +218,7 @@ struct mgmt_rp_user_confirm_reply {
>>  #define MGMT_OP_USER_PASSKEY_REPLY   0x001C
>>  struct mgmt_cp_user_passkey_reply {
>>       bdaddr_t bdaddr;
>> -     uint32_t passkey;
>> +     __le32 passkey;
>>  } __packed;
>
> Otherwise the patch looks ok but this change shouldn't be in it.  __le32
> is only for the kernel side.
>
Tanks for the comment, I used it since the kernel was using le32, and
the structure
allocated was u32? Dont we require to do the type casting?
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
