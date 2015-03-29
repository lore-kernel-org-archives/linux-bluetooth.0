Return-Path: <cyrus@holtmann.org>
Message-ID: <5517BC3E.3000806@cchtml.com>
Date: Sun, 29 Mar 2015 03:47:58 -0500
From: Michael Cronenworth <mike@cchtml.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: header change affects c++ projects
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

The move of "bswap_128()" in commit 
232015aeefd1c945ccfaf9744e791c5888eafcf7 breaks C++ projects. 
Specifically: The bswap_128() function is, without a cast, assigning a 
void* to a uint8_t*.

Can someone please review this commit? The message claims it is a "fix" 
but all I see is code copy and pasted along with a precision loss from 
uint128_t to uint8_t.

Thank you,
Michael
