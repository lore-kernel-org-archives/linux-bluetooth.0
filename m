Return-Path: <eramoto.masaya@jp.fujitsu.com>
Subject: Re: [PATCH v2] Support to change set file via arg
To: C Shapiro <shapiroc@chromium.org>
References: <20170705161602.95344-1-shapiroc@chromium.org>
 <1c5fb2d7-8671-b5f7-9773-0454ee3ca7da@jp.fujitsu.com>
 <CALM0h1kjYUQrcxu_uOzMNMqVkntzSTjcjox17kqOeBxG2yFo7Q@mail.gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Simon Glass
	<sjg@chromium.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <b7cb7c6d-1ed2-1344-6a62-b8024dbd247c@jp.fujitsu.com>
Date: Fri, 7 Jul 2017 18:04:28 +0900
MIME-Version: 1.0
In-Reply-To: <CALM0h1kjYUQrcxu_uOzMNMqVkntzSTjcjox17kqOeBxG2yFo7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

Thank you for answering my stupid questions.

> Why do not you pass DeviceID as an argument instead of a config file?
>  - This would be viable also, but then this arg could contradict the
> config file setting and allowing the config file to be passed is more
> powerful overall.

I think you don't have to manage your config files if you pass DeviceID 
as the argument. However it seems like better idea to pass an config 
file as the argument.

Regards,
Eramoto
