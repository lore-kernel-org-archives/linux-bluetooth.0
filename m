Return-Path: <cyrus@holtmann.org>
Message-ID: <52823071.2060207@linux.intel.com>
Date: Tue, 12 Nov 2013 15:43:13 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 1/4] android/pan: Add PAN related defines and event struct
 to hsl-msg header
References: <1384181621-8070-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1384181621-8070-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131112133328.GG22931@x220.p-661hnu-f1>
In-Reply-To: <20131112133328.GG22931@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/12/2013 03:33 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Mon, Nov 11, 2013, Ravi kumar Veeramally wrote:
>> +#define HAL_EV_PAN_CONN_STATE			0x81
>> +struct hal_ev_pan_conn_state {
>> +	uint8_t  state;
>> +	uint8_t  status;
>> +	uint8_t  bdaddr[6];
>> +	uint8_t  local_role;
>> +	uint8_t  remote_role;
>> +} __attribute__((packed));
>> +
>> +#define HAL_EV_PAN_CTRL_STATE			0x82
>> +struct hal_ev_pan_ctrl_state {
>> +	uint8_t  state;
>> +	uint8_t  status;
>> +	uint8_t  local_role;
>> +	uint8_t  name[17];
>> +} __attribute__((packed));
> These are in different in hal-ipc-api.txt:
>
>          Opcode 0x81 - Control State notification
> 	Opcode 0x82 - Connection State notification
>
> You really need to start paying more attention to details like this. As
> long as you don't do it it means I need to spend more time verifying
> every detail in your patches, which in turn means that it takes longer
> before your patches get reviewed and eventually go upstream.
>
> Johan
>
  Really sorry about that and wasting your time. I will keep that in mind.
  Sorry once again.

  Regards,
  Ravi.
