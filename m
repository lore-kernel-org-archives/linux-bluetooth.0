Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: Correct use of le_set_scan_response_data_cp / hci_send_req ?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOE8yMDJOB2iNnS6DFyE2=GBbKTEd4GPE_KcNCPT1d1eaUyzfw@mail.gmail.com>
Date: Fri, 17 Oct 2014 13:46:33 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <A3918155-03E6-4545-9929-563122917221@holtmann.org>
References: <CAOE8yMDJOB2iNnS6DFyE2=GBbKTEd4GPE_KcNCPT1d1eaUyzfw@mail.gmail.com>
To: mvogt1@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> I try to create a btle server which does advertise itsself with the
> name "HEY".
> 
> Attached is a demo program.
> Compile with:
> 
> g++ -o leserv leserv.cpp -lbluetooth
> 
> then start the program as root.
> And on another host start:
> 
> hcitool lescan
> 
> The current version prints "HEY" but I think the API
> is wrong here. Every other version which can be found
> on the internet uses the
> 
> // does not work
> //hci_le_set_scan_response_data(hciSocket,(uint8_t*)msg,strlen(msg),0);
> 
> implementation, and this one does not work.
> 
> What would be a correct example for this task?

you need to the read advertising data format struct. If you are configuring the scan response data, then it needs to follow the TLV format defined by the Bluetooth SIG.

Regards

Marcel

