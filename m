Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120419024536.GD1327@pcacjr.at.laptop>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-17-git-send-email-jprvita@openbossa.org>
	<20120419024536.GD1327@pcacjr.at.laptop>
Date: Thu, 26 Apr 2012 16:42:49 -0300
Message-ID: <CAAngNMb6DpVXYsNMbnLcOt0HzADWup8Oohj+b+TgQfa2VTem+w@mail.gmail.com>
Subject: Re: [RFC v2 16/16] HoG: Prepend report id to the HID report
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Paulo Alcantara <pcacjr@zytor.com>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/18 Paulo Alcantara <pcacjr@zytor.com>:
> Hi Joao,
>
> On Wed, Apr 18, 2012 at 07:08:24PM -0300, João Paulo Rechi Vita wrote:
>> If the report descriptor has a report id tag it have to be prepended
>> to the report data to construct the report itself.
>
> s/have/has/
>

Fixed, thanks.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
