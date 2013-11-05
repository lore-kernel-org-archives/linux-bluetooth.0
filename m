Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131105105732.GA8164@x220.p-661hnu-f1>
References: <1383647613-14951-1-git-send-email-marcin.kraglak@tieto.com>
	<20131105105732.GA8164@x220.p-661hnu-f1>
Date: Tue, 5 Nov 2013 12:05:47 +0100
Message-ID: <CABD6X-+0oT+-N55vpFjfkiObjKkbhgg1vJz5bsNvsB01oy=Vyg@mail.gmail.com>
Subject: Re: [PATCH 1/6] android: Initial implementation of get_remote_services
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 5 November 2013 11:57, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Marcin,
>
> On Tue, Nov 05, 2013, Marcin Kraglak wrote:
>> +static int bdaddr_cmp(gconstpointer a, gconstpointer b)
>> +{
>> +     const bdaddr_t *bda = a;
>> +     const bdaddr_t *bdb = b;
>> +
>> +     return bacmp(bdb, bda);
>> +}
>> +
>> +static bool fetch_remote_uuids(const bdaddr_t *addr)
>> +{
>> +     struct browse_req *req;
>> +     uuid_t uuid;
>> +
>> +     if (g_slist_find_custom(sdp_req_list, addr, bdaddr_cmp))
>> +             return false;
>> +
>> +     req = g_new0(struct browse_req, 1);
>> +     bacpy(&req->bdaddr, addr);
>> +     sdp_req_list = g_slist_append(sdp_req_list, &req->bdaddr);
>
> This is quite wild coding, having a list with pointers into the middle
> of a struct instead of the struct itself. To avoid having to twist ones
> brain around to figure out correctness, could you just store the request
> pointers in this list and then modify your bdaddr_cmp function to
> compare a struct browse_req against a bdaddr_t pointer instead of
> comparing two bdaddr pointers. You'll probably want to rename it to
> req_cmp or something similar then though.

Ok, I'll change it, it will be more readable.

>
>> +     sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
>> +
>> +     if (bt_search_service(&adapter->bdaddr,
>> +                     &req->bdaddr, &uuid, browse_cb, req, NULL) < 0) {
>> +             sdp_req_list = g_slist_remove(sdp_req_list, &req->bdaddr);
>> +             browse_req_free(req);
>
> Instead of having to do an extra g_slist_remove here why not just add
> the entry to the sdp_req_list only after bt_search_service has been
> successful?
>
> Also, how about renaming sdp_req_list to browse_req_list to match the
> name you've chosen for the context struct? Or maybe even simpler as
> "browse_reqs"

I agree.

>
>>  static uint8_t get_remote_services(void *buf, uint16_t len)
>>  {
>> -     return HAL_STATUS_UNSUPPORTED;
>> +     struct hal_cmd_get_remote_services *cmd = buf;
>> +     bool ret;
>> +     bdaddr_t addr;
>> +
>> +     android2bdaddr(&cmd->bdaddr, &addr);
>> +
>> +     ret = fetch_remote_uuids(&addr);
>> +
>> +     return ret ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
>>  }
>
> How about just making fetch_remote_uuids() return a proper HAL status
> directly instead of this mapping of bool to HAL status? You could also
> just consider merging the entire fetch_remote_uuids function (whose name
> I don't really like btw) into this get_remote_services function,
> especially if you don't foresee it having any other callers in the
> future.

I realized it in previous version, but fetch_remote_uuids will be called in
other places too (see next patches).

>
> Johan

BR
Marcin
