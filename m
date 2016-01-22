Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 22 Jan 2016 14:55:50 +0000 (UTC)
From: Hong-Rong Lin <physicist96@yahoo.com.tw>
Reply-To: Hong-Rong Lin <physicist96@yahoo.com.tw>
To: <linux-bluetooth@vger.kernel.org>
Message-ID: <1540612452.128426.1453474550259.JavaMail.yahoo@mail.yahoo.com>
Subject: A2DP AAC streaming Decoder
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1540612452.128426.1453474550259.JavaMail.yahoo.ref@mail.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
I would like to decode AAC payload from A2DP packets, and feed AAC data into AAC audio decoder to output audio, ie, Bluetooth speaker function supporting AAC streaming.
I have found there are sbc_decode() source code in pulseaudio-2.1, but I cannot find aac_decode().
Could all of you tell me how to get the aac_decode() source code and related application in the internet? Thanks a lot.
