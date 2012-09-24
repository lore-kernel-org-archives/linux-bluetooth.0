Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 07/18] neard: Implement PushOOB function
Date: Mon, 24 Sep 2012 16:38:18 +0200
Message-ID: <2284652.s6rmWXqmaz@uw000953>
In-Reply-To: <20120924090941.GA20042@x220>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com> <1348230995-8967-8-git-send-email-szymon.janc@tieto.com> <20120924090941.GA20042@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 24 of September 2012 12:09:41 Johan Hedberg wrote:
> Hi Szymon,

Hi Johan,

> On Fri, Sep 21, 2012, Szymon Janc wrote:
> > +static struct btd_adapter *pending_adapter = NULL;
> > +static DBusMessage *pending_msg = NULL;
> 
> I'm not really a fan of these global variables. Any chance of moving
> them to a non-global temporary context that gets passed around. 

The idea is to keep this plugin simple so only one request at time is to be
supported. mgmt code doesn't allow to pass any 'key-like' data to identify
command<->event so this would require some general (?) solution.
I don't think this is needed.

Actually, pending_adapter might not be needed if it is guaranteed that default
adapter will not change before callback is called (I guess it is).

> In
> general I find it hard to get the big picture on the life-time of these
> variables as it seems you don't actually explicitly initiate the pairing
> process from your code but are relying on some external entity to do
> that? Or did I miss something? The whole thing just looks quite brittle
> right now.

pending_* pointers are used to store data until read local or pairing callback
is called. Pairing is initiate in PushOOB method (adapter_create_bonding is
called from process_eir).

But yeah, I guess I should have been more descriptive in cover letter. So here
is few words of overview.

Currently handover agent API consists of 2 methods RequestOOB and PushOOB.

PushOOB is used to provide data and start pairing if needed to prepare
alternative carrier (BT). From NFC side this corresponds to receiving Handover
Select frame.

RequestOOB is used to request local data from BT to pass them to remote. This
method also allows to pass remote oob data without triggering pairing (to be
used when remote starts it) - this will minimize number of D-Bus calls
needed. From NFC side this corresponds to receiving (pass remote data and
request local data) or sending (only request local data) Handover Request
frame.

Basically there are 3 possible scenarios:
- neard received Handover Select message (aka static handover):
    neard calls PushOOB(data)
    bluez pairs if needed and reply

- neard received Handover Request and needs to reply with Handover Select:
    neard  calls RequestOOB(data)   and pass remote oob data received
    bluez stores received data, reads local OOB data and reply to neard
    neard sends HS frame based on bluez reply
    [in that case remote is responsible to initialize pairing if needed]

- neard sends Handover Request and later receives Handover Select from remote:
    neard calls RequestOOB(NULL)
    bluez reads local OOB data and reply to neard
    neard sends Handover Request base on bluez reply
    neard receives Handover Select frame
    neard calls PushOOB(data)
    bluez pairs if needed and reply


Hope this clarify things a bit:)

> Johan

-- 
BR
Szymon Janc
