Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150213113347.GA11794@t440s.ger.corp.intel.com>
References: <1423226839-23935-1-git-send-email-gowtham.ab@samsung.com>
	<20150213113347.GA11794@t440s.ger.corp.intel.com>
Date: Fri, 13 Feb 2015 15:49:09 +0200
Message-ID: <CABBYNZLwGg6aNRmQXFJ6sX7MRSbBqSEcYg8fmkxtxEJ70sQqaA@mail.gmail.com>
Subject: Re: [PATCH] gatt-server: Fix mutlpile definition of same func
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Feb 13, 2015 at 1:33 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Fri, Feb 06, 2015, Gowtham Anandha Babu wrote:
>> --- a/src/shared/gatt-helpers.h
>> +++ b/src/shared/gatt-helpers.h
>> @@ -105,3 +105,5 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
>>                                       bt_gatt_discovery_callback_t callback,
>>                                       void *user_data,
>>                                       bt_gatt_destroy_func_t destroy);
>> +
>> +void put_uuid_le(const bt_uuid_t *src, void *dst);
>
> gatt-helpers.h uses a namespace prefix of "bt_gatt" so you should at the
> very least conform to that. The function name would then become e.g.
> bt_gatt_put_uuid(). Besides that I don't have any objections to the
> patch.

You are absolutely right, this function does not belong here, Ive send
and patch moving it to lib/uuid.h where bt_uuid is implemented since
it is given as parameter here.

@Gowtham, I hope you are paying attention to the outcome of these changes.


-- 
Luiz Augusto von Dentz
