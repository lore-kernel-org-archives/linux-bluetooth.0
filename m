Return-Path: <cyrus@holtmann.org>
Message-ID: <539EDCC2.8070908@linux.intel.com>
Date: Mon, 16 Jun 2014 15:02:10 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] android/health: Cache health application data on
 app register call
References: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1402578618-31484-3-git-send-email-ravikumar.veeramally@linux.intel.com> <1536603.hQuXxHqAUl@uw000953>
In-Reply-To: <1536603.hQuXxHqAUl@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 06/16/2014 11:23 AM, Szymon Janc wrote:
> Hi Ravi,
>
> On Thursday 12 of June 2014 16:10:14 Ravi kumar Veeramally wrote:
>> ---
>>   android/health.c | 188 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 182 insertions(+), 6 deletions(-)
>>
>> +
>> +static void bt_health_register_app(const void *buf, uint16_t buf_len)
>> +{
>> +	const struct hal_cmd_health_reg_app *cmd = buf;
>> +	struct hal_rsp_health_reg_app rsp;
>> +	struct health_app *app;
>> +	uint16_t off, len;
>> +
>> +	DBG("");
>> +
>> +	app = new0(struct health_app, 1);
> Check if allocation succeed.
>
>> +	app->id = queue_length(apps) + 1;
>> +	app->num_of_mdep = cmd->num_of_mdep;
>> +
>> +	off = 0;
>> +
>> +	if (cmd->provider_name_off)
>> +		len = cmd->provider_name_off;
>> +	else if (cmd->service_name_off)
>> +		len = cmd->service_name_off;
>> +	else if (cmd->service_descr_off)
>> +		len = cmd->service_descr_off;
>> +	else
>> +		len = cmd->len;
> Offsets can be only increased so length is always next offset - current offset
> ie.
>
> app_name_len = provider_name_off - app_name_off
> provider_name_len = service_name_off - provider_name_off;
> etc.
>
> Also how about factoring this to helper ie. create_health_app() ?
> struct health_app *create_health_app(const uint8_t *app_name, uint16_t app_len,
>                                       const uint8_t *provider_name, uint16_t provider_len, ...., int mdeps)
>
> and then just call it like:
>
> app_name = cmd->data + cmd->app_name_off;
> app_len = cmd->provider_name_off - cmd->app_name_off;
> ....
>
> app = create_health_app(app_name, app_len, ....);
> if (!app) {
>      status = HAL_STATUS_FAILED;
>      goto failed;
> }
>
> This should make code more readable.
  I realized after modifying according to your comments. problem here is 
not all
strings are mandatory. Only app_name is present always, rest is optional.

app_name = cmd->data + cmd->app_name_off;
app_len = cmd->provider_name_off - cmd->app_name_off;

this is good only if all offset are present, e,g. : if offset value for 
provider_name
is 0 then we have to go for service_name_off, if service_name_off is 0, 
then go
for service_name_off , if service_name_off  is zero, the finally it is 
cmd data length.

Just in case for app name length if rest are optional.

	if (cmd->provider_name_off)
		len = cmd->provider_name_off;
	else if (cmd->service_name_off)
		len = cmd->service_name_off;
	else if (cmd->service_descr_off)
		len = cmd->service_descr_off;
	else
		len = cmd->len;


so, I would keep this code as it is. any comments?
>
>> +
>> +	app->app_name = malloc0(len);
> Check if allocation succeed.
>
>> +	memcpy(app->app_name, cmd->data, len);
>> +	off += len;
>> +
>> +	if (cmd->provider_name_off) {
> You should be checking for length, not offset here.
>
>> +		if (cmd->service_name_off)
>> +			len = cmd->service_name_off - cmd->provider_name_off;
>> +		else if (cmd->service_descr_off)
>> +			len = cmd->service_descr_off - cmd->provider_name_off;
>> +		else
>> +			len = cmd->len - cmd->provider_name_off;
>> +
>> +		app->provider_name = malloc0(len);
>> +		memcpy(app->provider_name, cmd->data + off, len);
>> +		off += len;
>> +	} else {
>> +		app->provider_name = NULL;
> Else is not needed as struct is already zeroed.
>
>> +	}
>> +
>> +	if (cmd->service_name_off) {
>> +		if (cmd->service_descr_off)
>> +			len = cmd->service_descr_off - cmd->service_name_off;
>> +		else
>> +			len = cmd->len - cmd->service_name_off;
>> +
>> +		app->service_name = malloc0(len);
>> +		memcpy(app->service_name, cmd->data + off, len);
>> +		off += len;
>> +	} else {
>> +		app->service_name = NULL;
>> +	}
>> +
>> +	if (cmd->service_descr_off) {
>> +		len = cmd->len - cmd->service_descr_off;
>> +
>> +		app->service_descr = malloc0(len);
>> +		memcpy(app->service_descr, cmd->data + off, len);
>> +		off += len;
>> +	} else {
>> +		app->service_descr = NULL;
>> +	}
>> +
>> +	if (app->num_of_mdep > 0)
>> +		app->mdeps = queue_new();
> I'd always allocate queue for sanity. It will just be empty if no mdeps.
>

Regards,
Ravi.
