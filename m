Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAHv3KG6NteONyJ1oM9Lakc=iMBGc0OZvpDKB-YTeN7ugjvd2w@mail.gmail.com>
References: <CAAHv3KHnRM=7WYgy-teqUZfFYNoGPdkOb0dgf3t4XiuYtoUOOA@mail.gmail.com>
 <CAAHv3KG6NteONyJ1oM9Lakc=iMBGc0OZvpDKB-YTeN7ugjvd2w@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 20 Aug 2012 14:44:03 -0300
Message-ID: <CAMOw1v5vTZpCYwCMSZjUmGYE65W63rKVH8r5_6Z43reNrPq02w@mail.gmail.com>
Subject: Re: Setting up an A2DP server
To: Niklas Claesson <nicke.claesson@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 17, 2012 at 6:50 PM, Niklas Claesson
<nicke.claesson@gmail.com> wrote:
> I've actually solved the issue myself by writing an Agent that accepts

You could mark the device as trusted, so you don't have to do this.


> all incoming requests, and another python script that polls 'pacmd
> list-sources' every 2 seconds for new bluetooth sources. And third and

Why do you need this?


Lucas De Marchi
