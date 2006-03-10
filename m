Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060310172525.GJ4516@beta.private.mielke.cc>
References: <20060309064424.584539d2.fotopiper@o2.pl> <20060309055552.GB4516@beta.private.mielke.cc> <20060309070649.007fba22.fotopiper@o2.pl> <20060309061255.GC4516@beta.private.mielke.cc> <20060309192953.52ee8c2e.fotopiper@o2.pl> <20060309193423.GF4516@beta.private.mielke.cc> <20060309225521.0f407da9.fotopiper@o2.pl> <20060309230420.05dc3497.fotopiper@o2.pl> <20060310013307.GG4516@beta.private.mielke.cc> <20060310082859.57eaf23b.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+xNpyl7Qekk2NvDX"
In-Reply-To: <20060310082859.57eaf23b.fotopiper@o2.pl>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Mar 2006 12:25:25 -0500


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[quoted lines by Radek Rurarz on 2006/03/10 at 08:28 +0100]

>iPAQs or rather Familiar in general have a BusyBox all in one
>executable, at least for the basic comands.
>Bash is not present, it could be instaled, but at great expense of free
>space (or even not passible, doto lack of space).
>The executable has only sh, and I'm not sure is it a 100% full
>implementation.

Please try the attached updated script. I think I've removed all the bashisms. 
My /bin/sh, however, supports more than it should so it's hard for me to be
sure.

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/

--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bluepin

#!/bin/sh
# This script has been written by Dave Mielke <dave@mielke.cc>. It's a light 
# weight, text mode, Bluetooth PIN helper script.
#
# Step 1: The PINs file, /etc/bluetooth/pins (can be changed with the -f
# option), is searched for a line which corresponds to the Bluetooth address of
# the device. Each line in this file should contain the address of a device and
# its PIN, in that order, separated by space. Any additional data on the line
# is ignored and can be used as a comment to help identify the device. For
# example, if the address of your cell phone is 01:23:45:67:89:AB, and if its
# PIN is 12345, then its line would look like this:
#
#    01:23:45:67:89:AB 12345 my cell phone
#
# If the address is found within the PINs file then the corresponding PIN is
# returned.
#
# Step 2: If the -c option has been specified then its operand is interpreted
# as the command which is to be used to prompt the user for the PIN. If it is
# appropriately quoted so that it can contain space then options may be
# specified after the command name. It must interpret its positional parameters
# and return its response as if it were being directly invoked as a Bluetooth
# PIN helper. If it returns a PIN then that PIN is returned.
#
# Step 3: If the -n option has not been specified then the user is prompted for
# the PIN via a text-mode dialog in a free virtual terminal. The console
# automatically returns to the original virtual terminal as soon as the user
# responds to the dialog. If the response contains at least one character then
# the entire response is returned as the PIN.
#
# Step 4: Return the fact that the PIN could not be determined.
#
# Error messages are written to the system log (syslog) if "logger" is in the
# command search path ($PATH) and if standard output is not a terminal (tty or
# pty). If any of these conditions is not satisfied then errors are written to
# standard error.
#
# Invoke this script with the -h option to see its usage summary.

configurationDirectory="/etc/bluetooth"
defaultPinCommand=""
defaultPinsFile="${configurationDirectory}/pins"
defaultAcceptableModes="600"

programName="${0##*/}"
programMessage() {
   echo >&2 "${programName}: ${1}"
}

programError() {
   programMessage "${2}" error
   exit "${1}"
}

syntaxError() {
   programError 2 "${1}"
}

findCommand() {
   variable="${1}"
   shift
   command="${1}"

   while [ "${#}" -gt 0 ]
   do
      path="`which "${1}" 2>/dev/null`"
      [ -n "${path}" ] && {
         eval "${variable}"'="${path}"'
         return 0
      }
      shift
   done

   programMessage "command not found: ${command}"
   return 1
}

respondWithPin() {
   echo "PIN:${1}"
   exit 0
}

[ ! -t 1 ] && {
   findCommand loggerPath logger && {
      programMessage() {
         "${loggerPath}" -t "${programName}[${$}]" -p "daemon.${2:-warning}" -- "${1}"
      }
   }
}

showUsage=false
pinCommand="${defaultPinCommand}"
pinsFile="${defaultPinsFile}"
acceptableModes="${defaultAcceptableModes}"
promptUser=true
pinLimit=16

while getopts ":c:f:hm:n" option
do
   case "${option}"
   in
      c) pinCommand="${OPTARG}";;
      f) pinsFile="${OPTARG}";;
      h) showUsage=true;;
      m) acceptableModes="${OPTARG}";;
      n) promptUser=false;;
     \?) syntaxError "invalid option: -${OPTARG}";;
      :) syntaxError "missing operand: -${OPTARG}";;
      *) syntaxError "unimplemented option: -${option}";;
   esac
done
shift `expr "${OPTIND}" - 1`

"${showUsage}" && {
   cat <<END_USAGE
Usage: ${programName} [-option ...] connection-direction device-address [device-name]
-c command  The command to prompt for a PIN not in the PINs file.${defaultPinCommand:+ [${defaultPinCommand}]}
-f file     The PINs file.${defaultPinsFile:+ [${defaultPinsFile}]}
-h          This command usage summary.
-m modes    The modes (in octal) that the PINs file may have.${defaultAcceptableModes:+ [${defaultAcceptableModes}]}
-n          Do not prompt for the PIN.
END_USAGE
   exit 0
}

[ "${#}" -eq 0 ] && syntaxError "connection direction not supplied"
connectionDirection="${1}"
shift

if [ "${connectionDirection}" = "out" ]
then
   connectionAdjective="outgoing"
   connectionPreposition="to"
else
   [ "${connectionDirection}" = "in" ] || programMessage "unexpected connection direction: ${connectionDirection}"
   connectionAdjective="incoming"
   connectionPreposition="from"
fi

[ "${#}" -eq 0 ] && syntaxError "device address not supplied"
deviceAddress="${1}"
shift

if [ "${#}" -eq 0 ]
then
   deviceName=""
else
   deviceName="${1}"
   shift
fi

[ `expr " ${acceptableModes}" : ' [0-7]*$'` -eq 4 ] || syntaxError "invalid file permission modes: ${acceptableModes}"
[ "${acceptableModes#0}" = "${acceptableModes}" ] && acceptableModes="0${acceptableModes}"

[ -n "${pinsFile}" -a -f "${pinsFile}" ] && {
   if [ ! -r "${pinsFile}" ]
   then
      programMessage "file not readable: ${pinsFile}"
   else
      if [ -z "${acceptableModes}" ]
      then
         safeModes=true
      else
         safeModes=false
         if findCommand statPath stat
         then
            actualModes="`"${statPath}" -c '%a' -- "${pinsFile}"`"
            [ "${actualModes#0}" = "${actualModes}" ] && actualModes="0${actualModes}"
          # if ((actualModes & ~acceptableModes))
            if false
            then
               programMessage "unsafe file permission modes: ${pinsFile}: ${actualModes} > ${acceptableModes}"
            else
               safeModes=true
            fi
         else
            programMessage "file permission modes not verifiable: ${pinsFile}"
         fi
      fi

      "${safeModes}" && {
         exec <"${pinsFile}"
         while read address pin comment
         do
            [ "${address}" = "${deviceAddress}" ] && respondWithPin "${pin}"
         done
         exec <&-
      }
   fi
}

[ `expr " ${pinCommand}" : ' *[^ ]'` -gt 0 ] && {
   set -- ${pinCommand} "${connectionDirection}" "${deviceAddress}"
   [ -n "${deviceName}" ] && set -- "${@}" "${deviceName}"
   response="`"${@}" | head -1`"
   pin="${response#PIN:}"
   [ "${pin}" != "${response}" ] && respondWithPin "${pin}"
}

"${promptUser}" && {
   findCommand openPath open openvt && {
      dialogTitle="Bluetooth PIN Prompt"
      dialogTime="`date '+%Y-%m-%d@%H:%M:%S'`"
      dialogPrompt="Enter PIN for ${connectionAdjective} Bluetooth connection ${connectionPreposition} ${deviceName}[${deviceAddress}]"

      findCommand dialogPath dialog && {
         pin="`"${openPath}" 3>&1 -s -w -- "${dialogPath}" --output-fd 3 --clear --title "${dialogTitle}" --cr-wrap --max-input "${pinLimit}" --inputbox "${dialogTime}\n\n${dialogPrompt}" 0 0 ""`"
         [ -n "${pin}" ] && respondWithPin "${pin}"
      }
   }
}

echo "ERR"
exit 0

--+xNpyl7Qekk2NvDX--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
