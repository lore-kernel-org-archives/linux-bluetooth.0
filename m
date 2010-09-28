Return-Path: <cyrus@holtmann.org>
Message-ID: <4CA1C01A.3040403@comarch.com>
Date: Tue, 28 Sep 2010 12:14:50 +0200
From: Lukasz Pawlik <lukasz.pawlik@comarch.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: How to send stream via obexd without ending request
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I want to stream data immediately after they appear and wait for next 
part. So far I didn't manage to find a way how to do this properly. 
Returning error EAGAIN from my read function leads to canceling request 
and this is something I don't want to do. The other way I was able to 
find is returning value > 0 from read function until last part of data 
appear. Obexd will stream data when buffer exceed allocated memory chunk 
and return to read more data. This is no solution because it forces 
obexd to send empty streams. Does anyone knows how to solve this problem ?

-- 
Łukasz Pawlik
