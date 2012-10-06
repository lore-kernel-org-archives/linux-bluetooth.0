Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349530857.27233.45.camel@aeonflux>
References: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
	<1349530857.27233.45.camel@aeonflux>
Date: Sat, 6 Oct 2012 18:09:16 +0300
Message-ID: <CABBYNZLfkNu5-Jynoz14hY9U2bY77qzG0_yQJCoYAw+H5UUqQw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] gdbus: Remove connection from g_dbus_remove_watch
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 6, 2012 at 4:40 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> The connection is not really needed since the list of listeners is
>> global not per connection, besides it is more convenient this way as
>> only the id is needed.
>
> they are not global, they are per connection. That we do not fully
> implement this correctly is another story. That should be fixed here.

Not sure if Im following you, the point here is that the caller only
need to store the id because the data that the id refer to already
store the connection as context. Btw let me paste what
g_dbus_remove_watch does:

	for (ldata = listeners; ldata; ldata = ldata->next) {
		data = ldata->data;

		cb = filter_data_find_callback(data, id);
		if (cb) {
			filter_data_remove_callback(data, cb);
			return TRUE;
		}
	}

So as per current implementation the listeners are global, you can
argue it is not very efficient and can cause extra iteration if there
are more connections but overall this seems to pay off to avoid having
the caller to manage connection. Btw this is the same approach glib
uses regarding io watches, they are global so you don't have to store
the GIOChannel together with the id to be able to remove them as the
g_source_remove only takes the id.

-- 
Luiz Augusto von Dentz
