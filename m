Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [BUG] unit/test-gatt failure uninitialized pointer(?)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
 <CABBYNZ+90yuLCDhEskujMK0jbqAM=VoGQYj6AQqz=Np8wyEhnw@mail.gmail.com>
 <fa6ffb78-74c9-6797-5a69-c46948341b2a@message-id.googlemail.com>
 <a26a80a9-f727-785b-4baa-62a9dc83bf56@message-id.googlemail.com>
 <CABBYNZ+7_+6jxuazNgSo61+KprWD8dcyrkcapTA5HjDuCze7Pg@mail.gmail.com>
 <55f07989-54e8-7e31-9a0c-536f1febf633@message-id.googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Message-ID: <2239b6c8-febb-3040-0315-b39b2c391cc3@message-id.googlemail.com>
Date: Mon, 29 May 2017 14:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <55f07989-54e8-7e31-9a0c-536f1febf633@message-id.googlemail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 29.05.2017 14:10, Stefan Seyfried wrote:
> It should probably be reproducible by unloading and blacklisting the af_alg module on your machine.

I just tried this and this reproduces the infinite hang just fine. It does not crash the test, though.

-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
