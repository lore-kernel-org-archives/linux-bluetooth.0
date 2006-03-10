Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060310230429.GN4516@beta.private.mielke.cc>
References: <20060309225521.0f407da9.fotopiper@o2.pl> <20060309230420.05dc3497.fotopiper@o2.pl> <20060310013307.GG4516@beta.private.mielke.cc> <20060310082859.57eaf23b.fotopiper@o2.pl> <20060310172525.GJ4516@beta.private.mielke.cc> <20060310191346.077462e0.fotopiper@o2.pl> <20060310183933.GK4516@beta.private.mielke.cc> <20060310202247.0ae102c2.fotopiper@o2.pl> <20060310205503.GL4516@beta.private.mielke.cc> <20060310232425.6ee10249.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M/SuVGWktc5uNpra"
In-Reply-To: <20060310232425.6ee10249.fotopiper@o2.pl>
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
Date: Fri, 10 Mar 2006 18:04:29 -0500


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[quoted lines by Radek Rurarz on 2006/03/10 at 23:24 +0100]

>Works.. both on PC and the iPAQ..

Excellent! Here's a slightly newer copy wherein the -h output shows what can go
into the configuration file as well as what should go into the pins file. 

There's just one line I need to fix as it still uses a bashism which I have yet
to figure out how to do in Bourne Shell syntax. It's commented out for the time
being (look for #fix). The effect of this is that the file mode check isn't
being enforced.

Assuming that I'm not being too presumptuous, what's the right way to now go
about requesting that this script become the new PIN helper? My suggestion is
to rename the current helper to xbluepin, and to place at least "command
xbluepin" into the configuration file for this script.

Can anyone think of any more enhancements?

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/

--M/SuVGWktc5uNpra
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
# Invoke this script with the -h option to see a summary of its options,
# parameters, and configuration file syntax.

programName="${0##*/}"
configurationDirectory="/etc/bluetooth"
configurationFile="${configurationDirectory}/${programName}.conf"
defaultPinCommand=""
defaultPinsFile="${configurationDirectory}/pins"
defaultAcceptableModes="600"

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

setVariable() {
   eval "${1}"'="${2}"'
}

findCommand() {
   variable="${1}"
   shift
   command="${1}"

   while [ "${#}" -gt 0 ]
   do
      path="`which "${1}" 2>/dev/null`"
      [ -n "${path}" ] && {
         setVariable "${variable}" "${path}"
         return 0
      }
      shift
   done

   programMessage "command not found: ${command}"
   return 1
}

isReadableFile() {
   [ -f "${1}" ] && {
      if [ ! -r "${1}" ]
      then
         programMessage "file not readable: ${1}"
      else
         return 0
      fi
   }
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

[ -n "${configurationFile}" ] && isReadableFile "${configurationFile}" && {
   exec <"${configurationFile}"
   lineNumber=0
   while read attribute setting
   do
      lineNumber=`expr "${lineNumber}" + 1`

      case "${attribute}"
      in
         '') continue;;
         \#*) continue;;

         command)
            variable=pinCommand
            type=string
            ;;

         file)
            variable=pinsFile
            type=word
            ;;

         modes)
            variable=acceptableModes
            type=word
            ;;

         prompt)
            variable=promptUser
            type=flag
            ;;

         *) type=invalid;;
      esac

      problem=""
      if [ "${type}" = "invalid" ]
      then
         problem="invalid attribute: ${attribute}"
      elif [ "${type}" != "string" ]
      then
         if [ "${setting}" = "" ]
         then
            problem="missing attribute setting: ${attribute}"
         else
            excess="${setting#* }"
            if [ "${excess}" != "${setting}" ]
            then
               problem="excess data: ${excess}"
            elif [ "${type}" = "flag" ]
            then
               case "${setting}"
               in
                  yes|ye|y|true|tru|tr|t|on) setting=true;;
                  no|n|false|fals|fal|fa|f|off|of) setting=false;;
                  *) problem="invalid flag setting: ${setting}";;
               esac
            elif [ "${type}" = "word" ]
            then
               [ "${setting}" = "off" ] && setting=""
            else
               problem="unimplemented attribute type: ${type}"
            fi
         fi
      fi

      if [ -n "${problem}" ]
      then
         programMessage "error at ${configurationFile}[${lineNumber}]: ${problem}"
      else
         setVariable "${variable}" "${setting}"
      fi
   done
   exec <&-
}

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
Options:
   -c command  The command to prompt for a PIN not in the PINs file.${defaultPinCommand:+ [${defaultPinCommand}]}
   -f file     The PINs file.${defaultPinsFile:+ [${defaultPinsFile}]}
   -h          This command usage summary.
   -m modes    The modes (3 octal digits) that the PINs file may have.${defaultAcceptableModes:+ [${defaultAcceptableModes}]}
   -n          Do not prompt for the PIN.

Configuration File Syntax: [${configurationFile}]
   # comment (blank lines are ignored too)
   file {/path/to/pins-file | off}
   modes {three-digit-octal-number | off}
   command [name [argument ...]]
   prompt {yes | no}

PINs File Syntax: [${defaultPinsFile}]
   device-address PIN comment ...
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

[ -n "${acceptableModes}" ] && {
   [ `expr " ${acceptableModes}" : ' [0-7]*$'` -eq 4 ] || syntaxError "invalid file permission modes: ${acceptableModes}"
   [ "${acceptableModes#0}" = "${acceptableModes}" ] && acceptableModes="0${acceptableModes}"
}

[ -n "${pinsFile}" ] && isReadableFile "${pinsFile}" && {
   if [ -z "${acceptableModes}" ]
   then
      safeModes=true
   else
      safeModes=false
      if findCommand statPath stat
      then
         actualModes="`"${statPath}" -c '%a' -- "${pinsFile}"`"
         [ "${actualModes#0}" = "${actualModes}" ] && actualModes="0${actualModes}"
#fix     if ((actualModes & ~acceptableModes))
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

--M/SuVGWktc5uNpra--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
