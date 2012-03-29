Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YZZjK-AGxvi_y54HiOMHHKJu5BvXgyWDPOaZENi7xy1Fg@mail.gmail.com>
References: <1333031224-26358-1-git-send-email-szymon.janc@tieto.com>
	<CAN_7+YZZjK-AGxvi_y54HiOMHHKJu5BvXgyWDPOaZENi7xy1Fg@mail.gmail.com>
Date: Fri, 30 Mar 2012 00:45:27 +0200
Message-ID: <CAN_7+Ybo7pj8sJeLbquj4K8BD6Dv=AQoNBr8vVyVAQ3ftV6Zxg@mail.gmail.com>
Subject: Re: [RFC 1/2] SAP: Add Terminate method to org.bluez.SimAccess
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hi Szymon,

>
> On Thu, Mar 29, 2012 at 4:27 PM, Szymon Janc <szymon.janc@tieto.com>
> wrote:
>>
>> This method will trigger server to immediate disconnect from client.
>> This is required to pass TP/DCN/BV-03-I.
>>

 Are you saying that DisconnectImmediate method in sap-dummy is not enough
 pass TP/DCN/BV-03-I?

 \Lukasz
