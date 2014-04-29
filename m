Return-Path: <cyrus@holtmann.org>
Message-ID: <535FAEB8.7080908@tieto.com>
Date: Tue, 29 Apr 2014 15:52:56 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Use common code for server and client register
References: <1398695000-6446-1-git-send-email-jakub.tyszkowski@tieto.com> <1491436.EFYgZNmm4q@uw000953>
In-Reply-To: <1491436.EFYgZNmm4q@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 04/29/2014 03:31 PM, Szymon Janc wrote:
> Hi Jakub,
>
> On Monday 28 of April 2014 16:23:20 Jakub Tyszkowski wrote:
>> As clients and servers are stored on a single list we can use common
>> code in both of register handlers.
>> ---
>>   android/gatt.c | 121 ++++++++++++++++++++++++---------------------------------
>>   1 file changed, 50 insertions(+), 71 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index e634aa6..1454000 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -154,8 +154,6 @@ static struct queue *gatt_apps = NULL;
>>   static struct queue *gatt_devices = NULL;
>>   static struct queue *app_connections = NULL;
>>
>> -static int32_t app_id = 1;
>> -
>>   static struct queue *listen_clients = NULL;
>>
>>   static void bt_le_discovery_stop_cb(void);
>> @@ -534,55 +532,64 @@ static void destroy_gatt_app(void *data)
>>   	free(app);
>>   }
>>
>> -static void handle_client_register(const void *buf, uint16_t len)
>> -{
>> -	const struct hal_cmd_gatt_client_register *cmd = buf;
>> -	struct hal_ev_gatt_client_register_client ev;
>> -	struct gatt_app *client;
>> -	uint8_t status;
>> -
>> -	DBG("");
>>
>
> Double empty line.
>
>> -	memset(&ev, 0, sizeof(ev));
>> +static int handle_app_register(const uint8_t *uuid, gatt_app_type_t app_type,
>> +								uint8_t *status)
>
> I'd name this simply register_app(). Also *status parameter is not really useful
> since Java is not using it. Returning 0 is enough for error here.
>
> ev.client_if = handle_app_register(..);
> if (ev.client_if)
>    status = HAL_STATUS_SUCCESS;
> else ....
>
>> +{
>> +	static int32_t application_id = 1;
>> +	struct gatt_app *app;
>>
>> -	if (queue_find(gatt_apps, match_app_by_uuid, &cmd->uuid)) {
>> -		error("gatt: client uuid is already on list");
>> -		status = HAL_STATUS_FAILED;
>> -		goto failed;
>> +	if (queue_find(gatt_apps, match_app_by_uuid, (void *) uuid)) {
>> +		error("gatt: app uuid is already on list");
>> +		*status = HAL_STATUS_FAILED;
>> +		return 0;
>>   	}
>>
>> -	client = new0(struct gatt_app, 1);
>> -	client->type = APP_CLIENT;
>> -	if (!client) {
>> -		error("gatt: cannot allocate memory for registering client");
>> -		status = HAL_STATUS_NOMEM;
>> -		goto failed;
>> +	app = new0(struct gatt_app, 1);
>> +	app->type = app_type;
>> +	if (!app) {
>
> app was already dereferenced line above.
>
> app->type = app_type;
> should be after null check.
>
>> +		error("gatt: Cannot allocate memory for registering app");
>> +		*status = HAL_STATUS_NOMEM;
>> +		return 0;
>> +	}
>> +
>> +	if (app_type == APP_CLIENT) {
>> +		app->notifications = queue_new();
>> +		if (!app->notifications) {
>> +			error("gatt: couldn't allocate notifications queue");
>> +			destroy_gatt_app(app);
>> +			*status = HAL_STATUS_NOMEM;
>> +			return 0;
>> +		}
>>   	}
>>
>> -	client->notifications = queue_new();
>> -	if (!client->notifications) {
>> -		error("gatt: couldn't allocate notifications queue");
>> -		destroy_gatt_app(client);
>> -		status = HAL_STATUS_NOMEM;
>> -		goto failed;
>> +	memcpy(app->uuid, uuid, sizeof(app->uuid));
>> +
>> +	app->id = application_id++;
>> +
>> +	if (!queue_push_head(gatt_apps, app)) {
>> +		error("gatt: Cannot push app on the list");
>> +		free(app);
>
> destroy_gatt_app(app) here.
>
>> +		*status = HAL_STATUS_FAILED;
>> +		return 0;
>>   	}
>>
>> -	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
>> +	*status = HAL_STATUS_SUCCESS;
>> +	return app->id;
>> +}
>>
>> -	client->id = app_id++;
>> +static void handle_client_register(const void *buf, uint16_t len)
>> +{
>> +	const struct hal_cmd_gatt_client_register *cmd = buf;
>> +	struct hal_ev_gatt_client_register_client ev;
>> +	uint8_t status;
>>
>> -	if (!queue_push_head(gatt_apps, client)) {
>> -		error("gatt: Cannot push client on the list");
>> -		destroy_gatt_app(client);
>> -		status = HAL_STATUS_NOMEM;
>> -		goto failed;
>> -	}
>> +	DBG("");
>>
>> -	ev.client_if = client->id;
>> +	memset(&ev, 0, sizeof(ev));
>>
>> -	status = HAL_STATUS_SUCCESS;
>> +	ev.client_if = handle_app_register(cmd->uuid, APP_CLIENT, &status);
>>
>> -failed:
>>   	if (status == HAL_STATUS_SUCCESS)
>>   		ev.status = GATT_SUCCESS;
>>   	else
>> @@ -3069,45 +3076,17 @@ static void handle_server_register(const void *buf, uint16_t len)
>>   {
>>   	const struct hal_cmd_gatt_server_register *cmd = buf;
>>   	struct hal_ev_gatt_server_register ev;
>> -	struct gatt_app *server;
>> -	uint32_t status;
>> +	uint8_t status;
>>
>>   	DBG("");
>>
>>   	memset(&ev, 0, sizeof(ev));
>>
>> -	if (queue_find(gatt_apps, match_app_by_uuid, &cmd->uuid)) {
>> -		error("gatt: Server uuid is already on list");
>> -		status = HAL_STATUS_FAILED;
>> -		goto failed;
>> -	}
>> -
>> -	server = new0(struct gatt_app, 1);
>> -	server->type = APP_SERVER;
>> -	if (!server) {
>> -		error("gatt: Cannot allocate memory for registering server");
>> -		status = HAL_STATUS_NOMEM;
>> -		goto failed;
>> -	}
>> +	ev.server_if = handle_app_register(cmd->uuid, APP_SERVER, &status);
>>
>> -	memcpy(server->uuid, cmd->uuid, sizeof(server->uuid));
>> -
>> -	server->id = app_id++;
>> -
>> -	if (!queue_push_head(gatt_apps, server)) {
>> -		error("gatt: Cannot push server on the list");
>> -		free(server);
>> -		status = HAL_STATUS_FAILED;
>> -		goto failed;
>> -	}
>> -
>> -	ev.status = GATT_SUCCESS;
>> -	ev.server_if = server->id;
>> -
>> -	status = HAL_STATUS_SUCCESS;
>> -
>> -failed:
>> -	if (status != HAL_STATUS_SUCCESS)
>> +	if (status == HAL_STATUS_SUCCESS)
>> +		ev.status = GATT_SUCCESS;
>> +	else
>>   		ev.status = GATT_FAILURE;
>>
>>   	memcpy(ev.uuid, cmd->uuid, sizeof(ev.uuid));
>>
>

I'll fix all of these in v2.

Thanks,
Jakub

