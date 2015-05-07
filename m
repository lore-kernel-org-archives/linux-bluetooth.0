Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010D943988C6@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010D943988C6@EMBSVR01.ember.local>
Date: Thu, 7 May 2015 09:08:39 +0200
Message-ID: <CAMv5GbdcD==pTmDEYXZ90K0SCdR6gc6hSaAa20YmPHAskw1Y-Q@mail.gmail.com>
Subject: Re: Alternative to 'gattc' 'gatts' commands for Linux
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Ankur Patel <ankur@embertec.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

gattc, gatts are shortcuts of haltest (bluez tool for android hal
test) prefix commands related to client and server.

Instead of gattc you can use btgatt-client tool and gatts -
btgatt-server tool, both of them are in bluez/tools/ .

Br,
Grzegorz
