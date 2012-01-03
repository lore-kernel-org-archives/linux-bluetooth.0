Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Jan 2012 14:03:53 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [BUG] Sleeping inside a RCU reader
Message-ID: <20120103120351.GA12920@aemeltch-MOBL1>
References: <20120103015131.GA1239@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120103015131.GA1239@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Jan 02, 2012 at 10:51:31PM -0300, Vinicius Costa Gomes wrote:
> Hi,
> 
> I found this bug (trace attached) and I don't think I will be able to
> start working on it in the next 11 hours, so this email is to make
> the life of anyone who wants to work on it a little easier. (If anyone
> wishes to work on this, please respond this email).
> 
> I was able to reproduce it consistenly doing a "hciconfig <dev> down"
> with an established connection. I was using LE devices, but it seems that
> the types of the devices don't matter.
> 
> The problem is that cancel_delayed_work_sync() called inside
> hci_conn_del() is blocking, because of and called in the context of an RCU
> (inside hci_conn_hash_flush()).

I think that if the RCU code is not protected by rcu_read_{,un}lock then
it is OK to sleep (and this is updater anyway).

In that function "hci_conn_hash_flush" maybe it is better to use
list_for_each_entry instead of list_for_each_entry_rcu for better
readability?

Best regards 
Andrei Emeltchenko 

