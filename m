Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
References: <1306933529-4270-1-git-send-email-lkslawek@gmail.com>
Date: Wed, 1 Jun 2011 15:10:37 +0200
Message-ID: <BANLkTik6c0N8Oy9CZZak+Zn5JQ3F636CLQ@mail.gmail.com>
Subject: Re: [PATCH] Adjust parameters in obexd.service.in
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm not sure however if ignoring transport plugins when --plugin is
used is a good idea at all. There is no hint in --help text what user
would have to load to make obexd work. Also no list of available
plugins, thus this all is a bit confusing now.

BR,
Slawomir Bochenski
