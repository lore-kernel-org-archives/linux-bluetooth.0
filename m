Return-Path: <cyrus@holtmann.org>
Message-ID: <4CA0FA3D.9040100@sergej.pp.ru>
Date: Tue, 28 Sep 2010 00:10:37 +0400
From: Sergej Pupykin <ml@sergej.pp.ru>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Another "hci0 command tx timeout"
References: <4CA0E800.4000000@sergej.pp.ru> <20100927192108.GA5489@vigoh> <4CA0F1FE.8040006@sergej.pp.ru> <20100927194650.GB5489@vigoh>
In-Reply-To: <20100927194650.GB5489@vigoh>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  On 27.09.2010 23:46, Gustavo F. Padovan wrote:
>
> So that is the problem, you are removing btusb.
>
Do you mean that removing/inserting back btusb can damage something? I 
repeat it many times and it always works if bluetoothd stopped and 
always does not work if bluetoothd is running.
