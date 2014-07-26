Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RDryQ2h8iNuKnWQuC3qXiOtPriH5wFptTgFjv7ydw9pg@mail.gmail.com>
Date: Sat, 26 Jul 2014 05:35:26 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <66FC4C2E-5A3F-4EB8-9F2B-EF818B6C3874@holtmann.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org> <1406326123-10564-2-git-send-email-armansito@chromium.org> <30A4ADE6-330B-451B-AF32-A32A6F17F2BF@holtmann.org> <CAHrH25RDryQ2h8iNuKnWQuC3qXiOtPriH5wFptTgFjv7ydw9pg@mail.gmail.com>
To: Arman Uguray <armansito@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> what we have used a lot is the concept of an iterator in a lot of protocols that have complex return types. It makes it generic, flexible and most important it results in readable code.
>> 
>>        struct bt_gatt_result;
>>        struct bt_gatt_iter;
>> 
>>        bool bt_gatt_iter_init(struct bt_gatt_iter *iter,
>>                                struct bt_gatt_result *result);
>> 
> 
> I actually like this approach better. I guess this way, we can use the
> returned result structures as the basis of a GATT client database. I'm
> not yet convinced if src/shared/gatt-db is the correct approach for
> the client implementation. I still need to figure out the kinks but
> this sounds good.

not sure that bt_gatt_result should be used as a client database. It feels wrong since I think that lifetime of bt_gatt_result should be limited to the callback. Then again, trying something different and see how it works out never hurts.

>> One interesting advantage is that the bt_gatt_result could just store the result PDU as it is an we just return pointers to the next field. That would help us avoid having to copy data around.
>> 
> 
> We could. Though we have to copy the data from the PDU at least once
> at some point if the caller wants to store that data somewhere (since
> the PDU array is temporarily provided by bt_att).

As less copying of data and allocation of new structures as possible should be the key. There might be users that only need part of the information. They should have the ability to skip parts of the response without any extra memory allocation or copy of data.

>> For internal representation we might choose to allow linking multiple bt_gatt_result together and only return the head item. And then just let the bt_gatt_iter point to the next one when moved forward.
>> 
> 
> This sounds good. I suppose we would then also provide a free function
> for bt_gatt_result, instead of cleaning it up internally after the
> callback returns?

I think bt_gatt_result should only be valid in the context of the callback. That is normally how the result variable and iterators work. Their scope is limited. This makes them so easy to use and keeps the code simple.

>> I went through the whole patchset and besides this detail, it looks pretty solid. I let others have a look at it as well. So we could start applying patches and then change to an iterator approach or you fix it up before applying. What do you think?
>> 
> 
> I say let's merge these the way they are now. It's easier for me to
> submit one small patch that implements the iterator approach than
> having to rebase all of these. A single patch later would be easier to
> review as well.

I applied all patches now.

Regards

Marcel

