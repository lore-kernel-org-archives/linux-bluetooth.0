Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000301d0710d$273c2130$75b46390$@samsung.com>
References: <000301d0710d$273c2130$75b46390$@samsung.com>
Date: Tue, 7 Apr 2015 13:35:58 +0300
Message-ID: <CABBYNZ+9uwzT9rqsCSkk_9jaY6W-432QghbOQubk0kVN=GvA0w@mail.gmail.com>
Subject: Re: Query reagarding unit test-gatt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Bharat Bhusan Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Apr 7, 2015 at 11:30 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi All,
>
> I am currently adding test cases for GATT. I am unable to understand the
> behavior of the following scenario.
>
> When I execute the following test case,
> TP/GAW/CL/BV-08-C  - [Write Characteristic Descriptors - by Client]
>
> bluez$  ./unit/test-gatt -d -p /TP/GAW/CL/BV-08-C
>
>   GATT: > 12 08 00 01 02 03                                ......
>   GATT: < 13
>
> Test Summary
> ------------
> /TP/GAW/CL/BV-08-C                                   Passed       0.002
> seconds
>
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> Here I am able to write it successfully. But in service_db_1 declaration,
> 0x0008 handle is a descriptor with only read permission.
> As per its definition, it should return write not permitted error.
> Is there any bug in gatt-client procedure or test-gatt or is this the
> expected behavior ?

Check the raw pdu, from the client test cases the responses are self
generated so it doesn't actually check what it is in the database, but
we may want to change that.


-- 
Luiz Augusto von Dentz
