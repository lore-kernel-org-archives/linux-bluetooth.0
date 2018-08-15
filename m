Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: ken Clark <kenidevices@gmail.com>
Date: Wed, 15 Aug 2018 09:00:55 -0400
Message-ID: <CANB6vTtAXM8oPs4Mcmj+zfP-kq+AtW-pYG1jX+kG5CSha25yhw@mail.gmail.com>
Subject: Read Request callbacks
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are developing an application based on the client demo.
We need a callback that a read request is received so that we can
properly encrypt the read data, and then send the encrypted data as
the read response.

Are there any examples, demos or instructions on how to accomplish this?
>From what I see the current client demo is not indicating when a read
request is received, its just sending the data currently available in
the GATT DB.

Thanks,
ken
