Return-Path: <cyrus@holtmann.org>
Message-ID: <50F3E222.2060709@oss.bmw-carit.de>
Date: Mon, 14 Jan 2013 11:46:58 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] test: Make map script a command line client
References: <1357922675-11718-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1357937329.1806.84.camel@aeonflux> <CABBYNZJJCW0oUOo_7F0VFcZVEFCVHZJpwGndke6P3T2pR9MqBg@mail.gmail.com>
In-Reply-To: <CABBYNZJJCW0oUOo_7F0VFcZVEFCVHZJpwGndke6P3T2pR9MqBg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 01/13/2013 04:29 PM, Luiz Augusto von Dentz wrote:
> I wonder if we should complicate more the testing scripts adding such 
> futures or start working in a proper C tool such as bluetoothctl e.g. 
> obexctl? -- Luiz Augusto von Dentz -- To unsubscribe from this list: 
> send the line "unsubscribe linux-bluetooth" in the body of a message 
> to majordomo@vger.kernel.org More majordomo info at 
> http://vger.kernel.org/majordomo-info.html 

In my opinion it would be nice if the test scripts support most profile 
features that are implemented in bluez/obexd.
That's why I extended the map-client. I tried to keep it as simple as 
possible while focusing also on good testing usability.

The language used for the test scripts / programs doesn't matter that 
much since the scripts are mainly for developers/testers.
Python has some advantages, the scripts can be changed easily while 
working on new features.

However, until some script replacement tool is available, it still would 
make sense to extend/maintain the scripts that are there.

Regards,
Christian
