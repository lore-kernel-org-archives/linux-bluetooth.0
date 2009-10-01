Return-Path: <cyrus@holtmann.org>
Message-ID: <555143.39932.qm@web50209.mail.re2.yahoo.com>
Date: Thu, 1 Oct 2009 10:40:22 -0700 (PDT)
From: Marco Castillo <mabcastillo@yahoo.com>
Subject: Segmentatio fault on call to sdp_service_search_attr_req
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list:
Currently we're working on a bluetooth discovery appliance. The appliance first discovers the bluetooth devices nearby. Then the appliance asks to the bluetooth found devices if the current device has an OPP (Obex Push Profile) service enabled. For this matter we use the following code

uint16_t service_uuid_int=0x1105
uuid_t service_uuid;
uint16_t range = 0x1105;

sdp_uuid16_create(&service_uuid, service_uuid_int);

sdp_list_t *response_list=NULL, *search_list, *attrid_list;
search_list = sdp_list_append(0, &service_uuid);

attrid_list = sdp_list_append(0, &range);

response_list=NULL;
status = sdp_service_search_attr_req(mysession, search_list, SDP_ATTR_REQ_RANGE, attrid_list, &response_list);
  The variable mysession was correctly initialized using a sdp_connect call. We use the fixed value 0x1105 because that's the service_uuid for OPP. If we use the previous code for a given number of discovered bluetooth devices once, it works well. Our problem arises when we use these code again and again and again, in an endless loop, applied to the a new set of discovered devices (on each loop, we have a new set of discovered devices). Randomly, the code breaks in the call to sdp_service_search_attr_req and our program prints the following nasty message:
Segmentation fault
We have some questions: do we have to use another considerations in the call to sdp_service_search_attr_req? the initializations we use here were taken from the bluetooth programming book BLUETOOTH ESSENTIALS FOR PROGRAMMERS from Albert S. Huang - Larry Rudolph.
We're developing these code using gnu g++ 4.3.2-7 on a Fedora 10 machine. The libraries we have installed are bluez 4.30.2 for fedora 10. 
Following the uname -a command output
Linux vdk4linux 2.6.27.30-170.2.82.fc10.i686 #1 SMP Mon Aug 17 08:38:59 EDT 2009 i686 i686 i386 GNU/Linux
The machine is a pentium m laptop, with 1 GB memory (Dell Inspiron 1500).
Thank you in advance for any help or any kind reply.

Regards


Marco


      
