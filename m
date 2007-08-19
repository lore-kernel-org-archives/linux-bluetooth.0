Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46C88AA3.70800@stud.cs.uit.no>
Date: Sun, 19 Aug 2007 21:23:31 +0300
From: "Harald S. Hanssen" <haraldsh@stud.cs.uit.no>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Developing a interactive service for bluetooth devices
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi there.

I'm been trying to develop a bluetooth software that can send and 
receive data from a server - client view. I'm doing the development in 
PyBluez (might have to change it if something else supports all the 
operations i need to do).

I want to create sort of an interactive bluetooth service, where the 
user operates the bluetooth device to interact with a server to get 
information. The data excahnged between the sides is either text or a 
image. My biggest problem is to be able to send data back and forth.

I've been looking at obexftp, however that library seems (to me at 
least) to only support push operation and not pull. I can't figure out 
how to send something from for example to my phone (client) and to my 
laptop (aka the server) and back.

I've been looking at the source code from several known programs, 
however, they confuse me more than help (due to the lack of comments ..).

I'm using bluez for the sdp query, mostly due to the fact I can't see 
anything similar in obexftp. Obexftp just detects devices as far as I 
can see (correct me if I'm wrong)

I know this is the mailing list for Bluez, I dunno how much you've been 
into obexftp. Any insight in the matter would anyway be quite nice.

Harold

The code I've written so far is:

--------------------------------------------------------------------------------------------------------------------

## This example is a combo of what you may find at
## the bluez and the obexftp homepage..

import bluetooth
import obexftp

SVC_HOST        =       0
SVC_PROTOCOL    =       1
SVC_PORT        =       2
SVC_SERVICE_ID  =       3

## Locates the bluetooth devices nearby and returns the
## the list of devices to locate_services
def locate_btd():
    target_address = None
    target_name = None
   
    # doing a sdp query (to put it bluntly
    nearby_devices = bluetooth.discover_devices()
   
    for bdaddr in nearby_devices:
            target_name = bluetooth.lookup_name(bdaddr)
            print "Discovered: %s" % target_name
   
    return nearby_devices

## Locates the services depending wheter there are
## are any devices nearby by using Bluez
## Might be done by obexftp, however obexftp does not
## indicate afaik the port
def locate_services():
   
    bt_devices = []
   
    print "Searching for services.."
       
    # Locate all the bluetooth devices in the area
    btd = locate_btd()
      
    if btd == None:
        exit(0)
   
    print "length of btd: %d" % len(btd)
       
    for target in btd:       
        services = bluetooth.find_service(address=target)
   
        if len(services) == 0:
            print "The device does not have the required service: %s" % 
bluetooth.lookup_name(target)
           
        else:
            print " ----------------------------------- "
            for svc in services:
                if svc["name"] == "OBEX Object Push":
                    print "Found Required Service on Bluetooth Device"
                    print "____________________________________ "
                    print "Service Name: %s"    % svc["name"]
                    print "    Host:        %s" % svc["host"]
                    print "    Hostname:    %s" % 
bluetooth.lookup_name(target)
                    print "    Description: %s" % svc["description"]
                    print "    Provided By: %s" % svc["provider"]
                    print "    Protocol:    %s" % svc["protocol"]
                    print "    channel/PSM: %s" % svc["port"]
                    print "    svc classes: %s "% svc["service-classes"]
                    print "    profiles:    %s "% svc["profiles"]
                    print "    service id:  %s "% svc["service-id"]
                    print ":::::::::::::::::::::::::::::::::::: "
                    print
                   
                    # STORES THE DEVICES THAT HAS THE REQUIRED SERVICES
                    bt_devices.append((svc["host"], svc["protocol"], 
svc["port"], svc["service-id"]))
           
    return bt_devices

# Broadcast the bt device has been spotted
def obexftp_send_message(bt_devices):
        data_message = "You have been spotted by a bluetooth service 
detector"
   
    i = 0
   
    ## just broadcasting after detecting devices..
    while i < len(bt_devices):
       
        client = obexftp.client(obexftp.BLUETOOTH)
       
        if (client.connectpush(bt_devices[i][SVC_HOST], 
bt_devices[i][SVC_PORT])) != 1:
            print "Could not send data to %s", bt_devices[i][SVC_HOST]
        #print bt_devices[i][SVC_HOST]
        #print bt_devices[i][SVC_PORT]
       
        # can't use put_file() for some reason...
        # must add extension to make it, hence the .txt at the end
        if (client.put_data(data_message, "INFO.txt")) != 1:
            print "error: breaking"   
       
        i = i + 1
       
   
## Need to know wheter the service the clients provides
## supports the obex service...
def obex_handler():
   
    # Are there any services
    bt_devices = locate_services()
    print bt_devices

    i = 0

    # trying to connect
    while i < len(bt_devices):
        if bt_devices[i][SVC_PROTOCOL] != 'RFCOMM':  
            print "The device %s has a mismatching protocol %s" % 
(bt_devices[i][SVC_HOST], bt_devices[i][SVC_PROTOCOL])
            bt_devices.pop[i]
            exit(0)
        i = i + 1
       
    obexftp_send_message(bt_devices)
  

obex_handler()

---------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
