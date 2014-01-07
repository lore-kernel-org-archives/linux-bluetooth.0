Return-Path: <cyrus@holtmann.org>
Message-ID: <52CBED43.3030505@linux.intel.com>
Date: Tue, 07 Jan 2014 14:04:19 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH_v2 1/4] android/pan: Register Network Access Point
References: <1389093533-13210-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1389093533-13210-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20140107115539.GA2107@x220.p-661hnu-f1>
In-Reply-To: <20140107115539.GA2107@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 01/07/2014 01:55 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Jan 07, 2014, Ravi kumar Veeramally wrote:
>> +static int set_forward_delay(void)
>> +{
>> +	FILE *f;
>> +	char *path;
>> +
>> +	path = g_strdup_printf("/sys/class/net/%s/bridge/forward_delay",
>> +								BNEP_BRIDGE);
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	f = fopen(path, "r+");
>> +	g_free(path);
>> +	if (!f)
>> +		return -errno;
> The above is not safe since g_free() might modify the value of errno.
>
> In general, we're not really in the habit of using the f* variants of
> file access functions. Could you convert the above to use a stack
> variable for path (there's a PATH_MAX variable you can use for its
> size) together with sprintf and use open + write instead of fopen +
> fprintf?
   Ok, I will change it.
>> +static int nap_create_bridge(void)
>> +{
>> +	int sk, err;
>> +
>> +	DBG(" %s", BNEP_BRIDGE);
> Why the extra space before %s?
  I will remove it.
>
>> +	if (ioctl(sk, SIOCBRADDBR, BNEP_BRIDGE) == -1) {
> We usually check for this kind of errors with < 0 instead of == -1.
   Ok.
>
>> +	DBG(" %s", BNEP_BRIDGE);
> Same thing here with the seemingly unnecessary space.
   Ok, I will remove it.

  Regards,
  Ravi.
