Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] API for MAP client in obex-client
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Thu, 03 Nov 2011 14:52:15 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <CAPGrrxXkvaNjnUT9vJ8sdnHuabF7zwtWnOnnbLD1+G0huvj1xw@mail.gmail.com>
References: <CAPGrrxXkvaNjnUT9vJ8sdnHuabF7zwtWnOnnbLD1+G0huvj1xw@mail.gmail.com>
Message-ID: <9a761ff17e9379d239fb223e2bc4440f@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 03.11.2011 14:44, schrieb Bartosz Szatkowski:
> Hi,
> below proposed API for MAP client in obex-client, for now just some
> generic functions and browsing support.
>
> Messages Access hierarchy
> =========================
>
> Service         org.openobex.client
> Interface       org.openobex.MessagesAccess

Are there any plan on switching to a different namespace?
Using openobex was always in conflict with previously existing software 
(o-d-s) and with the switch to gobex for the client, it's even less 
correct.

HS

