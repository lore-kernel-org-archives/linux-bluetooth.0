Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 3 Dec 2014 16:51:16 -0800
Message-ID: <CAPt0RYyJH9eYC=BPs0U6RR4JXj4UyM3jjnS+Sa8RStNPed6WYw@mail.gmail.com>
Subject: packed structs in bluez code
From: Mona Attariyan <monattar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I have a simple question. I'm wondering about all the packed structs
in bluez (e.g. many examples in lib/hci.h). Is it to make sure that
the size of the struct does not change due to padding based on the
architecture?

Thanks,
