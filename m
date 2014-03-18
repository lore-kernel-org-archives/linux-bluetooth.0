Return-Path: <cyrus@holtmann.org>
Message-ID: <5328356A.3060704@linux.intel.com>
Date: Tue, 18 Mar 2014 14:00:42 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: johan.hedberg@gmail.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH_v4] android/hal-health: Add HDP .register_application
 method
References: <1395141776-14428-1-git-send-email-ravikumar.veeramally@linux.intel.com> <20140318114822.GA17578@johan-t440s.lan>
In-Reply-To: <20140318114822.GA17578@johan-t440s.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 03/18/2014 01:48 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Mar 18, 2014, Ravi kumar Veeramally wrote:
>> +static bool string_to_hal(const char *str, struct hal_string *hstr,
>> +								ssize_t *len)
>> +{
>> +	if (!hstr || !len)
>> +		return false;
>> +
>> +	if (!str) {
>> +		hstr->len = 0;
>> +		return true;
>> +	}
>> +
>> +	hstr->len = strlen(str) + 1;
>> +	*len += hstr->len;
>> +	if (*len > IPC_MTU)
>> +		return false;
> Usually we design APIs so that a failure means the return parameters
> were left untouched. The way you've implemented this here the caller
> couldn't know if *len or hstr->len were modified in case false is
> returned. We should be more predictable than that. So please fix up the
> function so that it only touches the parameters if true is returned.
>
  Ok, I'll fix that.

Thanks,
Ravi.
