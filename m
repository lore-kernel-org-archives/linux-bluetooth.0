Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 11 Mar 2014 14:44:46 -0700
Message-ID: <CAHZ1yC=+XNxEx5ivA+ebGi_Cjui2Mcrx+q83b-eUPvt2J0XLPw@mail.gmail.com>
Subject: rctest -c "Can't connect: Device or resource busy (16)"
From: Scott James Remnant <keybuk@chromium.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is this expected behavior for RFCOMM? When using rctest -r on one
side, and rctest -c (connect/disconnect/connect...) on the other, the
client side fails to connect a significant percentage of the time:

rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Connected [handle 34817, class 0xff8801, priority 0]
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)
rctest[23705]: Can't connect: Device or resource busy (16)

Scott
