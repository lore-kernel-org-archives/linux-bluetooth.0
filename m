Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Oct 2009 02:58:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
Message-ID: <20091022235858.GA20063@jh-x301>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1256253562-22532-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

A few quick coments on this:

On Thu, Oct 22, 2009, Jaikumar Ganesh wrote:
> +static void update_service_records(struct btd_device *device) {

Coding style: opening bracket of a function on its own line.

>  	records = read_records(&src, &device->bdaddr);
> +	for (l = device->uuids; l; l = l->next) {
> +		uuid = l->data;
> +		rec = find_record_in_list(records, uuid);
> +		if (rec)
> +			records = sdp_list_remove(records, rec);
> +	}

It looks like you're leaking memory here. I guess rec should be freed
after the sdp_list_remove.

> +	for (seq = records; seq; seq = seq->next) {
> +		rec = (sdp_record_t *) seq->data;

Since seq->data is void* the cast is unnecessary here.

> +		delete_record(srcaddr, dstaddr, rec->handle);
> +	}
> +	if (records)
> +		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
> +}

Coding style: I'd add empty lines between the for-loops as well as before
the if-statement here.

Other than those issues one thing that bothers me a little is that it
seems the req->profiles_removed list isn't used anymore at this point but
a list of removed records is built from scratch a second time. Are you
sure that this existing list of removed UUIDs couldn't be used somehow to
make the code more efficient? It might well be that this I'm missing
something and this list can't be used but I thought it'd be good to check
that you've considered this possibility nevertheless.

Johan
