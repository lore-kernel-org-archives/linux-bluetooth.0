Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428068636-13073-5-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
	<1428068636-13073-5-git-send-email-mariusz.skamra@tieto.com>
Date: Tue, 7 Apr 2015 10:50:43 +0300
Message-ID: <CABBYNZK0gc4A6UaZHRZq5OJo1f2Vadd8QkCyOXWQ1LcAWFWj1A@mail.gmail.com>
Subject: Re: [PATCHv2 04/27] android/hog: Remove tracking gatt operations
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Fri, Apr 3, 2015 at 4:43 PM, Mariusz Skamra <mariusz.skamra@tieto.com> wrote:
> Since the use of bt_gatt_client there is no need to queue pending gatt
> operations. bt_gatt_client already keeps track on that, so that
> on bt_gatt_client_unref the queue of pending requests is destroyed.

This assumption that unref will properly cancel the pending request is
not correct, it will only do what you are saying if it is the last
reference so we still need to track the requests and properly cancel
them since we have no idea how many references of bt_gatt_client
exists.


-- 
Luiz Augusto von Dentz
