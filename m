Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
 <CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
 <CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com> <CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com>
From: Leon Nicholls <lnicholls@google.com>
Date: Tue, 27 Oct 2015 19:58:25 -0700
Message-ID: <CAHmfHqS_jW0vLA14wMz939BNV1XKzUr7BG+_h_4Xzq1LywLz+w@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In my web app I don't explicitly do a scan for devices. That is done
somewhere inside the polymer element or even the Web Bluetooth API in
Chrome. I'm going to experiment with using the Web Bluetooth API
directly to eliminate one level of abstraction.
