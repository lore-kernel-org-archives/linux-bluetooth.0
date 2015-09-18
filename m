Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB512Gtwysk7k8dr9PPLDr_n+iGke01Z39YaW0mZBmuo1YUw0w@mail.gmail.com>
References: <CAB512Gtwysk7k8dr9PPLDr_n+iGke01Z39YaW0mZBmuo1YUw0w@mail.gmail.com>
Date: Fri, 18 Sep 2015 11:45:22 +0300
Message-ID: <CABBYNZJARVfmT=FEnQcyp4fbjySXXjAuzcOYEXU0+JdYd7HaKg@mail.gmail.com>
Subject: Re: Query about GATT Client WriteValue dbus method
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Seungyoun Ju <sy39.ju@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 18, 2015 at 10:39 AM, Seungyoun Ju <sy39.ju@samsung.com> wrote:
> Hello, All.
>
> If a remote GATT server's characteristic only supports
> BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP, src/gatt-clieint.c's WriteValue
> dbus method reaches to bt_gatt_client_write_without_response().
> And the return value is kept in chrc->write_id.
>
> But there is no point to clear this chrc->write_id.
> So next time WriteValue call is failed with in progress error.

I guess you mean there is no callback to clear it so it is obviously
wrong to store it in the write_id, we should probably fix that.

> If chrc->write_id is cleared immediately after
> bt_gatt_client_write_without_response(),
> client->pending_requests queue would be grown up infinitely when
> application calls this method repeatedly and fastly after dbus method
> return.

We could rate limit, maybe clear write_id on timeout, but then what if
the application has to write as fast as possible? Anyway for now I
think I would just reset the write_id until we come up with some
solution for stream of data, we may actually limit the queue size in
bt_gatt_client if memory is a concern.

> Is there anyone who meets such an issue ?
>
> If there is anyone who struggled with this kind of issue,
> can you help me how to solve this ?
>
> Thanks and Regards,
> Seungyoun Ju.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
